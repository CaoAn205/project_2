class ImageMask < ApplicationRecord
  mount_uploader :file, FileUploader

  belongs_to :image
end
