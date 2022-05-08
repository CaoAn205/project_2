class FileUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  process :store_file_size, :store_file_name

  def store_file_size
    return unless file.size
    model.file_size = (file.size.to_f / 1.megabyte).round(3)
  end

  def store_file_name
    return if model.file_name
    model.file_name = original_filename
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}"
  end

  def extension_allowlist
    %w(jpg jpeg gif png svg)
  end
end
