class Category < ApplicationRecord
  belongs_to :user
  belongs_to :friendship, optional: true
  has_many :items, dependent: :destroy

  validates :user, uniqueness: { scope: :title }
end
