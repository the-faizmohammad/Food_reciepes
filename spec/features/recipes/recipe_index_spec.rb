require 'rails_helper'

RSpec.describe 'Recipe', type: :system do
  before :each do
    RecipeFood.delete_all
    Food.delete_all
    Recipe.delete_all
    User.delete_all
    @user = User.create(name: 'User', surname: 'Spec', email: 'testing@gmail.com', password: 'testing')
    @r1 = Recipe.create(user: @user, name: 'Recipe one', preparation_time: 1, cooking_time: 2,
                        description: 'Recipe one description', public: true)
    @r2 = Recipe.create(user: @user, name: 'Recipe two', preparation_time: 2, cooking_time: 3,
                        description: 'Recipe two description', public: false)
    @r3 = Recipe.create(user: @user, name: 'Recipe three', preparation_time: 1, cooking_time: 1,
                        description: 'Recipe three description', public: true)
  end

  context 'user logs in successfully' do
    it 'should redirect to the root path' do
      visit new_user_session_path
      sleep(1)

      fill_in 'Email', with: @user.email
      fill_in 'Password', with: 'testing'

      click_button 'Log in'
      sleep(1)
      expect(current_path).to eq(root_path)
      expect(page).to have_content('Signed in successfully.')
    end
  end

  context '#index' do
    it 'should direct to recipes index' do
      visit new_user_session_path
      sleep(1)

      fill_in 'Email', with: @user.email
      fill_in 'Password', with: 'testing'

      click_button 'Log in'
      sleep(1)
      visit recipes_path
      sleep(1)
      expect(current_path).to eq(recipes_path)
    end
  end
end
