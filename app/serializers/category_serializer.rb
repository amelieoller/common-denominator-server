class CategorySerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower

  attributes :title
  has_many :items
end
