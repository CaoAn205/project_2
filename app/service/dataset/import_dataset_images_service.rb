require 'zip'

class Dataset::ImportDatasetImagesService
  class << self
    def import!(file_path, user, name)
      return unless File.exists?(file_path)

      dataset = Dataset.create!(name: name || "Dataset 1")
      extract_destination = extract_file(file_path, dataset.id)

      Dir.glob(Rails.root.join(extract_destination, 'images', '*')).each do |path|
        image = user.images.build(dataset: dataset)
        image.file = open(path)
        image.save!
      end

      dataset
    ensure
      FileUtils.rm_rf(extract_destination) if extract_destination.present?
    end

    private

    attr_reader :extract_destination

    def extract_file(zip_path, dataset_id)
      @extract_destination = "tmp/#{dataset_id}"
      FileUtils.mkdir_p(extract_destination) unless Dir.exists?(extract_destination)

      Zip::File.open(zip_path) do |zip_file|
        zip_file.each do |f|
          fpath = File.join(extract_destination, f.name)
          zip_file.extract(f, fpath) unless File.exist?(fpath)
        end
      end

      extract_destination
    end
  end
end
