class FriendshipSerializer < ActiveModel::Serializer
  attributes :custom_friendship_id

  has_many :categories
end
