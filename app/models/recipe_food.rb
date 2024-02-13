class RecipeFood < ApplicationRecord
  belongs_to :recipe_name, class_name: 'Recipe', foreign_key: 'recipe_id'
  belongs_to :food_name, class_name: 'Food', foreign_key: 'food_id'

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def calculate_value
    self.value = quantity * food_name.price.to_f
  end
end