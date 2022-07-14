class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :role_type

  def role_type
    object.role_type.capitalize
  end
end
