class ImageSerializer < ActiveModel::Serializer
  attributes :id, :file_url

  def file_url
    "#{Settings.default_host}#{object.file.path.gsub(/\/workspace\/public/, '')}" if Rails.env.development?
  end
end