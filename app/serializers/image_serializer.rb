class ImageSerializer < ActiveModel::Serializer
  attributes :id, :file_url, :file_name, :segmentation_mask, :confirmed

  def file_url
    # "#{Settings.default_host}#{object.file.path.gsub(/\/workspace\/public/, '')}" if Rails.env.development?
    "data:#{object.file.content_type};charset=utf-8;base64,#{Base64.encode64(File.read(object.file.path)).gsub('\n', '')}"
  end

  def file_name
    object.file.identifier
  end
  
  def segmentation_mask
    ImageMaskSerializer.new(object.segmentation_mask)
  end

  def confirmed
    object.image_sectors.present? && object.image_sectors.pluck(:confirmed_at).all?(&:present?)
  end
end