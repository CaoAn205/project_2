class DatasetSerializer < ActiveModel::Serializer
  attributes :id, :name, :images_count, :labels_count
end
