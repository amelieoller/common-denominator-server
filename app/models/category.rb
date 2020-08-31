class Category < ApplicationRecord
  belongs_to :user
  belongs_to :friendship, optional: true
  has_many :items, dependent: :destroy

  validates :user, uniqueness: { scope: :title, message: "You already have a category with the same name." }
  validates :title, presence: true

  before_create :add_slug

  def add_slug
    self.slug = self.title.parameterize
  end
end
