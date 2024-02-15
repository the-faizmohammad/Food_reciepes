require 'rails_helper'

RSpec.describe 'Recipe Foods new', type: :system do
  before(:each) do
    RecipeFood.delete_all
    Food.delete_all
    Recipe.delete_all
    User.delete_all
    @user = User.create(name: 'User', surname: 'Spec', email: 'testing@gmail.com', password: 'testing')
    @f1 = Food.create(user: @user, name: 'Foodone', measurement_unit: 'kg', price: 2, quantity: 5)
    @f2 = Food.create(user: @user, name: 'Foodtwo', measurement_unit: 'kg', price: 5, quantity: 4)
    @r1 = Recipe.create(user: @user, name: 'Recipe one', preparation_time: 1, cooking_time: 2,
                        description: 'Recipe one description', public: true)
  end

  it 'Adding new Ingredient' do
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    sleep(1)
    visit recipes_path

    visit foods_path

    visit new_recipe_recipe_food_path(@r1)

    expect(page).to have_content('Add Ingredients needed for Recipe')
    expect(page).to have_content('Food')
    expect(page).to have_content('Quantity')
    expect(page).to have_content('Select food Item')
    select 'Foodone', from: 'recipe_food[food_id]'
    fill_in 'Quantity', with: 2
    click_button 'Add Food'
    sleep(1)
    expect(current_path).to eq(recipe_path(@r1))
    expect(page).to have_content('Foodone')
  end
end
