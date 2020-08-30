class ItemSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower

  attributes :title
  belongs_to :category
end
