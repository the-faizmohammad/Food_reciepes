require 'rails_helper'

RSpec.describe 'Recipe Details', type: :system do
  before(:each) do
    RecipeFood.delete_all
    Food.delete_all
    Recipe.delete_all
    User.delete_all

    @user = User.create(name: 'User one', email: 'userone@gmail.com', password: 'userone')
    recipe = { user: @user, name: 'User one Recipe',
               description: 'Recipe one by user one description', preparation_time: 1, cooking_time: 1, public: true }
    @recipe = Recipe.create(recipe)
    @food = Food.create(user: @user, name: 'Food item', measurement_unit: 'kg', price: 1, quantity: 1)
    @food2 = Food.create(user: @user, name: 'New Food item', measurement_unit: 'kg', price: 1, quantity: 1)
    @recipe_food = RecipeFood.create(recipe_name: @recipe, food_name: @food, quantity: 2)
  end

  it 'shows the correct view of the recipe' do
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
    sleep(1)
    visit recipe_path(@recipe)
    sleep(1)
    expect(page).to have_content('User one Recipe')
    expect(page).to have_content("Cooking Time: #{@recipe.cooking_time}")
    expect(page).to have_content("Preparation Time: #{@recipe.preparation_time}")
    expect(page).to have_content("Description: #{@recipe.description}")
    expect(page).to have_content('Toggle')
    expect(page).to have_content('Generate General Shopping List')
    expect(page).to have_content('Add Ingredients')
  end

  context 'Public, Private Toggle action' do
    it 'changes the visibility of the recipe' do
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log in'
      sleep(1)
      visit recipe_path(@recipe)
      sleep(1)
      find('.toggle-button-container').click
      sleep(1)
      expect(page).to have_content('Toggle Public')
    end
  end

  context 'Modify action from the recipe foods table' do
    it 'redirects to modify path and updates the item' do
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log in'
      sleep(1)
      visit recipe_path(@recipe)
      sleep(1)
      click_link 'Modify'
      sleep(1)
      expect(current_path).to eq(edit_recipe_recipe_food_path(@recipe, @recipe_food))
    end
  end

  context 'Delete action fromt he table' do
    it 'Removes the food ingredient' do
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log in'
      sleep(1)
      visit recipe_path(@recipe)
      sleep(1)
      click_button 'Remove'
      sleep(1)
      expect(@recipe.recipe_foods.count).to eq 0
    end
  end

  context 'Generate Shopping List action' do
    it 'redirects to shopping list path' do
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log in'
      sleep(1)
      visit recipe_path(@recipe)
      sleep(1)
      click_link('Generate General Shopping List')
      sleep(1)
      expect(current_path).to eq(general_shopping_lists_path)
    end
  end

  context 'Add Ingredients action' do
    it 'redirects to Add new Ingredients path' do
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Log in'
      sleep(1)
      visit recipe_path(@recipe)
      sleep(1)
      click_link('Add Ingredient')
      sleep(1)
      expect(current_path).to eq(new_recipe_recipe_food_path(@recipe))
    end
  end
end