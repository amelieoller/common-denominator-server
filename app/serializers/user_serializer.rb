class UserSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower

  attributes :username
  has_many :friends
end
