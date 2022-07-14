class Image < ApplicationRecord
  mount_uploader :file, FileUploader
  paginates_per 20

  belongs_to :dataset, counter_cache: true
  belongs_to :user

  has_many :image_sectors, dependent: :destroy
end
