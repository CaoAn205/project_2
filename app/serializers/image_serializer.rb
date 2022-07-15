class ImageSerializer < ActiveModel::Serializer
  attributes :id, :file_url, :file_name, :segmentation_mask

  def file_url
    "#{Settings.default_host}#{object.file.path.gsub(/\/workspace\/public/, '')}" if Rails.env.development?
  end

  def file_name
    object.file.identifier
  end
  
  def segmentation_mask
    ImageMaskSerializer.new(object.segmentation_mask)
  end
end