class ImageMaskSerializer < ActiveModel::Serializer
  attributes :file_url

  def file_url
    return if object.file.blank?

    # "#{Settings.default_host}#{object.file.path.gsub(/\/workspace\/public/, '')}" if Rails.env.development?
    "data:#{object.file.content_type};charset=utf-8;base64,#{Base64.encode64(File.read(object.file.path)).gsub('\n', '')}"
  end
end
