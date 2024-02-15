require 'rails_helper'

RSpec.describe 'Recipe Foods edit', type: :system do
  before(:each) do
    RecipeFood.delete_all
    Food.delete_all
    Recipe.delete_all
    User.delete_all
    @user = User.create(name: 'User', surname: 'Spec', email: 'testing@gmail.com', password: 'testing')
    @r1 = Recipe.create(user: @user, name: 'Recipe one', preparation_time: 1, cooking_time: 2,
                        description: 'Recipe one description', public: true)
    @f1 = Food.create(user: @user, name: 'Food item one', measurement_unit: 'kg', price: 2, quantity: 5)
    @f2 = Food.create(user: @user, name: 'Food item two', measurement_unit: 'kg', price: 5, quantity: 4)
    @rf1 = RecipeFood.create(recipe_name: @r1, food_name: @f1, quantity: 3)
  end

  context 'should render index view' do
    it 'Modifying the Ingredient' do
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log in'
      sleep(1)

      visit edit_recipe_recipe_food_path(@r1, @rf1)

      expect(page).to have_content('Update Food Quantity')
      expect(page).to have_content('Update Food')
      expect(page).to have_content('Cancel')
      fill_in 'recipe_food_quantity', with: 5
      click_button 'Update Food'
      sleep(1)
      expect(current_path).to eq(recipe_path(@r1))
      expect(page).to have_content(5)
    end
  end
end
