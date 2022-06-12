class Image < ApplicationRecord
  mount_uploader :file, FileUploader

  belongs_to :dataset, counter_cache: true
  belongs_to :user
end
