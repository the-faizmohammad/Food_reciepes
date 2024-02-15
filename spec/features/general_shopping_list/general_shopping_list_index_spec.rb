require 'rails_helper'

RSpec.describe 'General shopping lists', type: :system do
  before(:each) do
    RecipeFood.delete_all
    Food.delete_all
    Recipe.delete_all
    User.delete_all
    @user = User.create(name: 'User', surname: 'Spec', email: 'testing@gmail.com', password: 'testing')
    @r1 = Recipe.create(user: @user, name: 'Recipe one', preparation_time: 1, cooking_time: 2,
                        description: 'Recipe one description', public: true)
    @f1 = Food.create(user: @user, name: 'Food item', measurement_unit: 'kg', price: 2, quantity: 2)
    @f2 = Food.create(user: @user, name: 'Food item two', measurement_unit: 'kg', price: 2, quantity: 2)
    @rf1 = RecipeFood.create(recipe_name: @r1, food_name: @f1, quantity: 2)
    @rf2 = RecipeFood.create(recipe_name: @r1, food_name: @f2, quantity: 2)
  end

  it 'should render index view' do
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    sleep(1)
    visit general_shopping_lists_path
    sleep(1)
    expect(page).to have_content('Shopping List')
    expect(page).to have_content('Total Foods to Buy: 2 items')
    expect(page).to have_content('Total Value: $')
    expect(page).to have_content(@f1.name)
  end
end
