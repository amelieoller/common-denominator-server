class UserSerializer < ActiveModel::Serializer
  attributes :id, :username
  has_many :friends
end
