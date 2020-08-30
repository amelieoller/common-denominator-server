class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :user, uniqueness: { scope: :item }
end
