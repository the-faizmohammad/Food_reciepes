require 'rails_helper'

RSpec.describe 'New Food', type: :system do
  before(:each) do
    RecipeFood.delete_all
    Food.delete_all
    Recipe.delete_all
    User.delete_all
    @user = User.create(name: 'User', surname: 'Spec', email: 'testing@gmail.com', password: 'testing')
    @r1 = Recipe.create(user: @user, name: 'Recipe one', preparation_time: 1, cooking_time: 2,
                        description: 'Recipe one description', public: true)
    @f1 = Food.create(user: @user, name: 'Food item', measurement_unit: 'kg', price: 2, quantity: 5)
  end

  context 'Adds new Food item' do
    it 'Instance to the table' do
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log in'
      sleep(1)
      visit new_food_path
      sleep(1)
      fill_in 'Name', with: @f1.name
      fill_in 'food_measurement_unit', with: @f1.measurement_unit
      fill_in 'Price', with: @f1.price
      fill_in 'Quantity', with: @f1.quantity
      click_button 'Add Food'
      sleep(1)
      expect(current_path).to eq(foods_path)
      expect(page).to have_content(@f1.name.to_s)
      expect(page).to have_content(@f1.measurement_unit.to_s)
      expect(page).to have_content('10')
    end
  end
end