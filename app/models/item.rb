class Item < ApplicationRecord
  belongs_to :category
  has_many :ratings, dependent: :destroy
  # belongs_to :user, through: :ratings

  after_create :create_rating

  def create_rating
    Rating.create(rating_options)
  end

  def rating_options
    { item_id: self.id, user: User.first, value: 0 }
  end
end
