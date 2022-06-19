class Dataset < ApplicationRecord
  has_many :images, dependent: :destroy
end
