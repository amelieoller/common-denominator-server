class ItemSerializer < ActiveModel::Serializer
  attributes :id, :title, :current_user_rating

  def current_user_rating
    Rating.where(item_id: self.object.id, user_id: 1).take
  end

  belongs_to :category
end
