class Label < ApplicationRecord
  belongs_to :dataset, counter_cache: true
end
