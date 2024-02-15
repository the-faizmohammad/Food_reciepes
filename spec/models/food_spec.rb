require 'rails_helper'

RSpec.describe Food, type: :model do
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

  context 'Food instance validations,' do
    it 'should hava name' do
      f2 = Food.create(user: @user, measurement_unit: 'kg', price: 2, quantity: 5)
      expect(f2).not_to be_valid
    end

    it 'should have price' do
      f2 = Food.create(user: @user, name: 'Food item', measurement_unit: 'kg', quantity: 5)
      expect(f2).not_to be_valid
    end

    it 'should have measurement_unit' do
      f2 = Food.create(user: @user, name: 'Food item', price: 2, quantity: 5)
      expect(f2).not_to be_valid
    end

    it 'should have user association' do
      f2 = Food.create(name: 'Food item', measurement_unit: 'kg', price: 2, quantity: 5)
      expect(f2).not_to be_valid
    end
  end
end
