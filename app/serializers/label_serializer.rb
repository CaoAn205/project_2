class LabelSerializer < ActiveModel::Serializer
  attributes :id, :category_name, :color_code, :category_code, 

  def color_code
    object.rgb_color_code
  end
end
