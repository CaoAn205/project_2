class ImageMaskSerializer < ActiveModel::Serializer
  attributes :file_url

  def file_url
    return if object.file.blank?

    "#{Settings.default_host}#{object.file.path.gsub(/\/workspace\/public/, '')}" if Rails.env.development?
  end
end
