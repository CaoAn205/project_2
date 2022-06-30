class LabelSerializer < ActiveModel::Serializer
  attributes :id, :category_name, :color_code, :category_code, 

  def color_code
    "rgb(#{object.color_code.gsub(/[^\d]/, '').split('').map { |e| (((e.to_i == 0) ? 0 : (1/e.to_f)) * 255).to_i }.join(',')})"
  end
end
