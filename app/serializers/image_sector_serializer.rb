class ImageSectorSerializer < ActiveModel::Serializer
  attributes :id, :label_rgb_color_code, :label_category_name, :area_data, :confirmed_at
end
