class ImageAttachment < ApplicationRecord
  mount_uploader :file, FileUploader

  belongs_to :user

  has_many :features
end
