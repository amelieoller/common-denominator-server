class User < ApplicationRecord
  has_secure_password

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :categories, dependent: :destroy
  has_many :items, through: :categories
  has_many :ratings, dependent: :destroy

  validates :username, { presence: true, uniqueness: true }
end
