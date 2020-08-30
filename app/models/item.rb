class Item < ApplicationRecord
  belongs_to :category
  has_many :ratings
  # belongs_to :user, through: :ratings
end
