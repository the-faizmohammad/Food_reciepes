class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, foreign_key: 'food_id'
  has_many :recipes, through: :recipe_foods

  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :name, presence: true, length: { maximum: 250 }
  validates :measurement_unit, presence: true
end