class CategorySerializer < ActiveModel::Serializer
  attributes :id, :title, :slug
  has_many :items
end
