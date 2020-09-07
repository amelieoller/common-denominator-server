class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"
  has_many :categories, foreign_key: :custom_friendship_id, primary_key: :custom_friendship_id

  after_create :create_inverse, unless: :has_inverse?
  after_destroy :destroy_inverses, if: :has_inverse?
  before_create :add_custom_friendship_id
  after_update :update_inverse, unless: :inverse_has_been_updated?

  # validates :value, harmony: { greater_than_or_equal_to: 0, less_than_or_equal_to: 2 }
  # validates :value, randomness: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }

  def update_inverse
    inverse_friendship = self.class.where(inverse_match_options).take
    inverse_friendship.update(inverse_match_options.merge({ harmony: harmony, randomness: randomness }))
  end

  def inverse_has_been_updated?
    inverse_friendship = self.class.where(inverse_match_options).take
    inverse_friendship.harmony == harmony && inverse_friendship.randomness == randomness
  end

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
