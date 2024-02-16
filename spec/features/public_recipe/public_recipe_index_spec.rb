require 'rails_helper'

RSpec.describe 'Public Recipe', type: :system do
  before(:each) do
    RecipeFood.delete_all
    Food.delete_all
    Recipe.delete_all
    User.delete_all
    @user = User.create(name: 'User', surname: 'Spec', email: 'testing@gmail.com', password: 'testing')
    @user2 = User.create(name: 'User two', surname: 'Spec', email: 'test@gmail.com', password: 'tttttt')
    @r1 = Recipe.create(user: @user, name: 'Recipe1 one', preparation_time: 1, cooking_time: 2,
                        description: 'Recipe one by user one description', public: true)
    @r2 = Recipe.create(user: @user2, name: 'Recipe2 one', preparation_time: 1, cooking_time: 2,
                        description: 'Recipe one by user two description', public: true)
    @r3 = Recipe.create(user: @user, name: 'Recipe1 two', preparation_time: 1, cooking_time: 2,
                        description: 'Recipe two by user one description', public: false)

    @f1 = Food.create(user: @user, name: 'Food item1', measurement_unit: 'kg', price: 2, quantity: 5)
    @f2 = Food.create(user: @user2, name: 'Food item2', measurement_unit: 'kg', price: 2, quantity: 6)

    @rf1 = RecipeFood.create(recipe_name: @r2, food_name: @f2, quantity: 3)
    @rf2 = RecipeFood.create(recipe_name: @r3, food_name: @f1, quantity: 5)
  end

  it 'Shows the public recipes index view' do
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    sleep(1)
    visit public_recipes_path
    sleep(1)
    expect(page).to have_content('Public Recipes by Users')
    expect(page).to have_content(@r1.name.to_s)
    expect(page).to have_content('By: User')
    expect(page).to have_content('Total food items: 0')
    expect(page).to have_content('Total price: $0')
    expect(page).to have_content(@r2.name.to_s)
    expect(page).to have_content('By: User two')
    expect(page).to have_content('Total food items: 1')
    expect(page).to have_content('Total price: $6.0')
    expect(page).not_to have_content(@r3.name.to_s)
  end

  context 'Public Recipe link action' do
    it 'redirects public recipe show view' do
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log in'
      sleep(1)
      visit public_recipes_path
      sleep(1)
      click_link @r1.name
      sleep(1)
      expect(current_path).to eq(public_recipe_path(@r1))
    end
  end
end
