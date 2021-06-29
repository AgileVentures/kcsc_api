class Users::Serializer < ActiveModel::Serializer
  attributes :id, :email, :name
end
