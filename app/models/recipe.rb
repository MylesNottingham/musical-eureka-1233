class Recipe < ApplicationRecord
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients

  validates :name, presence: true
  validates :complexity, presence: true
  validates :genre, presence: true

  def total_cost
    ingredients.sum(:cost)
  end
end
