require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  before :all do
    RecipeFood.delete_all
    Food.delete_all
    Recipe.delete_all
    User.delete_all
    @user = User.create(name: 'User', surname: 'Spec', email: 'testing@gmail.com', password: 'testing')
    @r1 = Recipe.create(user: @user, name: 'Recipe one', preparation_time: 1, cooking_time: 2,
                        description: 'Recipe one description', public: true)
    @f1 = Food.create(user: @user, name: 'Food item', measurement_unit: 'kg', price: 2, quantity: 5)
    @rf1 = RecipeFood.create(recipe_name: @r1, food_name: @f1, quantity: 2)
  end

  context 'checks quantity validation' do
    it 'Food should have quantity' do
      rf2 = RecipeFood.create(recipe_name: @r1, food_name: @f1)
      expect(rf2).not_to be_valid
    end

    it 'Food should have quantity' do
      rf2 = RecipeFood.create(food_name: @f1, quantity: 1)
      expect(rf2).not_to be_valid
    end

    it 'Food should have quantity' do
      rf2 = RecipeFood.create(recipe_name: @r1, quantity: 1)
      expect(rf2).not_to be_valid
    end
  end

  context '#calculate_value' do
    it 'returns value based on quantity and food price' do
      expect(@rf1.calculate_value).to eq(4)
    end
  end
end