require 'rails_helper'

RSpec.describe 'Public Recipe', type: :system do
  before(:each) do
    RecipeFood.delete_all
    Food.delete_all
    Recipe.delete_all
    User.delete_all
    @user2 = User.create(name: 'User two', surname: 'Spec', email: 'test@gmail.com', password: 'tttttt')
    @r2 = Recipe.create(user: @user2, name: 'Recipe2 one', preparation_time: 1, cooking_time: 2,
                        description: 'Recipe one by user two description', public: true)

    @f2 = Food.create(user: @user2, name: 'Food item2', measurement_unit: 'kg', price: 2, quantity: 6)

    @rf1 = RecipeFood.create(recipe_name: @r2, food_name: @f2, quantity: 3)
  end

  it 'Shows the public recipes show view' do
    visit new_user_session_path
    fill_in 'Email', with: @user2.email
    fill_in 'Password', with: @user2.password
    click_button 'Log in'
    sleep(1)
    visit public_recipes_path
    sleep(1)
    click_link @r2.name
    sleep(1)
    expect(page).to have_content(@r2.name.to_s)
    expect(page).to have_content("Preparation Time: #{@r2.preparation_time}")
    expect(page).to have_content("Cooking Time: #{@r2.cooking_time}")
    expect(page).to have_content("Description: #{@r2.description}")
    expect(page).to have_content('Ingredients')
    expect(page).to have_content(@f2.name.to_s)
    expect(page).to have_content('3')
  end
end
