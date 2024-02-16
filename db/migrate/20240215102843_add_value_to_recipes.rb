class AddValueToRecipes < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :value, :float
  end
end
