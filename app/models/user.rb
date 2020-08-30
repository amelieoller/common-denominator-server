class User < ApplicationRecord
  has_secure_password

  has_many :friendships
  has_many :friends, through: :friendships
  has_many :categories
  has_many :items, through: :categories
  has_many :ratings

  validates :username, { presence: true, uniqueness: true }
end
