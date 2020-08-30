class Category < ApplicationRecord
  belongs_to :user
  belongs_to :friendship
  has_many :items
end
