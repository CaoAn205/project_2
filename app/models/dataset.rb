class Dataset < ApplicationRecord
  has_many :images, dependent: :destroy
  has_many :labels, dependent: :destroy
end
