class ImageSector < ApplicationRecord
  belongs_to :image
  belongs_to :label

  delegate :category_name, :rgb_color_code, to: :label, allow_nil: true, prefix: true
end
