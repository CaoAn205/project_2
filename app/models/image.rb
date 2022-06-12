class Image < ApplicationRecord
  belongs_to :dataset, counter_cache: true
  belongs_to :user
end
