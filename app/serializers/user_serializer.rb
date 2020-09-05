class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :slug
  has_many :friends
end
