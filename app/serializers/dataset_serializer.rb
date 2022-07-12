class DatasetSerializer < ActiveModel::Serializer
  attributes :id, :name, :images_count, :labels_count

  def labels_count
    object.labels_count.to_i
  end

  def images_count
    object.images_count.to_i
  end
end
