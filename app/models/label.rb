class Label < ApplicationRecord
  belongs_to :dataset, counter_cache: true

  has_many :image_sectors
  def rgb_color_code
    "rgb(#{color_code.gsub(/[^\d]/, '').split('').map { |e| (((e.to_i == 0) ? 0 : (1/e.to_f)) * 255).to_i }.join(',')})"
  end
end
