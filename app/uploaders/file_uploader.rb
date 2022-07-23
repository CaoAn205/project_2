class FileUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  process resize_to_fill: [256, 256]

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}"
  end

  def extension_allowlist
    %w(jpg jpeg gif png svg)
  end

  def image?(_p)
    model.class.to_s.underscore === 'image'
  end
end
