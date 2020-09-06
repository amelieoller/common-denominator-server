class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"
  has_many :categories, foreign_key: :custom_friendship_id, primary_key: :custom_friendship_id

  after_create :create_inverse, unless: :has_inverse?
  after_destroy :destroy_inverses, if: :has_inverse?
  before_create :add_custom_friendship_id

  def add_custom_friendship_id
    lower = [self.user.id, self.friend.id].min
    higher = [self.user.id, self.friend.id].max

    self.custom_friendship_id = "#{lower}_#{higher}"
  end

  def create_inverse
    self.class.create(inverse_match_options.merge({ accepted: false }))
  end

  def destroy_inverses
    inverses.destroy_all
  end

  def has_inverse?
    self.class.exists?(inverse_match_options)
  end

  def inverses
    self.class.where(inverse_match_options)
  end

  def inverse_match_options
    { friend_id: user_id, user_id: friend_id }
  end
end
