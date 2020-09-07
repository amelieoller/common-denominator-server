class FriendshipSerializer < ActiveModel::Serializer
  attributes :custom_friendship_id, :harmony, :randomness, :id

  has_many :categories
end
