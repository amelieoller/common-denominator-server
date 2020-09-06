class Item < ApplicationRecord
  belongs_to :category
  has_many :ratings, dependent: :destroy
  # belongs_to :user, through: :ratings

  after_create :create_rating

  def create_rating
    category = Category.find(category_id)

    if (category.custom_friendship_id)
      ids = category.custom_friendship_id.split("_")
      user_id1 = ids[0].to_i
      user_id2 = ids[1].to_i

      Rating.create({ item_id: self.id, user_id: user_id1, value: 0 })
      Rating.create({ item_id: self.id, user_id: user_id2, value: 0 })
    else
      Rating.create({ item_id: self.id, user: category.user, value: 0 })
    end
  end

  # def rating_options(user)
  #   { item_id: self.id, user: Category.find(category_id).user, value: 0 }
  # end

end
