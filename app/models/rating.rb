class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :user, uniqueness: { scope: :item }
  validates :value, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
end
