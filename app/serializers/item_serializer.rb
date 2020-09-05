class ItemSerializer < ActiveModel::Serializer
  attributes :id, :title, :current_user_rating, :category_id

  def current_user_rating
    Rating.where(item_id: self.object.id, user_id: current_user.id).take
  end

  belongs_to :category
end
