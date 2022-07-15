require 'rest_client'

class Image::SegmentationService
  MAX_LABELS = 8

  def initialize image
    @image = image
    labels = image.dataset.labels
    @labels_indexes = labels.pluck(:color_code).map { |code| code.gsub(/[^\d]/, '').to_i(2) }
    @label_mapping = labels_indexes.map { |i| [i, labels.select { |l| l.color_code.gsub(/[^\d]/, '').to_i(2) == i }[0]] }.to_h
  end

  def execute!
    response_data = call_segmentation_api
    convert_response_into_area_data(response_data)
  end

  private

  attr_reader :image, :labels_indexes, :label_mapping

  def call_segmentation_api api = "http://#{ENV['LOCAL_IPV4']}:8000#{Settings.segnmentation_index_api}"
    response = RestClient.post(api, { :file => File.new(image.file.path, 'rb') })
    response.body
  end

  def convert_response_into_area_data(response)
    data = JSON.parse(response)
    height = data.size
    width = data.map { |row| row.size }.max

    area_data = labels_indexes.map { |i| [i, []] }.to_h

    data.each_with_index do |row, irow|
      change_pixels = row.each_with_index.map { |v, i| [row[i-1], v, i] if v != row[i-1] && i > 0 }.compact

      change_pixels.each_with_index do |pixel, ipoint|
        first_point_start = [irow, (ipoint != 0 ? change_pixels[ipoint-1][-1] : 0)]
        first_point_end = [irow, pixel[-1] - 1]

        area_data[pixel[0]] << [first_point_start, first_point_end]
      end
    end

    area_data.each do |k, v|
      label_mapping[k].image_sectors.new(image_id: image.id, area_data: v).save!
    end
  end
end
