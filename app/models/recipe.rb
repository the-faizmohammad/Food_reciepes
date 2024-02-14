class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, foreign_key: 'recipe_id'
  has_many :food_name, through: :recipe_foods, source: :food_name

  validates :name, presence: true, length: { maximum: 250 }
  validates :description, length: { maximum: 2000 }
  validates :preparation_time, numericality: { greater_than_or_equal_to: 0 }
  validates :cooking_time, numericality: { greater_than_or_equal_to: 0 }

  private

  def set_defaults
    self.public ||= false
  end
end
