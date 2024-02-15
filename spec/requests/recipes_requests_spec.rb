require 'rails_helper'

RSpec.describe 'Recipe', type: :request do
  describe 'GET /index' do
    before :all do
      RecipeFood.delete_all
      Food.delete_all
      Recipe.delete_all
      User.delete_all
      @user = User.create(id: 1, name: 'User', email: 'test@gmail.com', password: 'testtt')
      @recipe = Recipe.create(id: 1, user: @user, name: 'Recipe', description: 'Description',
                              preparation_time: 1, cooking_time: 1, public: true)
    end

    it 'returns http success, status' do
      sign_in @user
      get recipes_path
      expect(response).to be_successful
      expect(response.status).to eq(200)
    end

    it 'should render index view' do
      sign_in @user
      get recipes_path
      expect(response).to render_template(:index)
      expect(response.body).to include('Recipe')
    end
  end

  describe 'GET /index' do
    before :all do
      RecipeFood.delete_all
      Food.delete_all
      Recipe.delete_all
      User.delete_all
      @user = User.create(id: 1, name: 'User', email: 'test@gmail.com', password: 'testtt')
      @recipe = Recipe.create(id: 1, user: @user, name: 'Recipe', description: 'Description',
                              preparation_time: 1, cooking_time: 1, public: true)
    end

    it 'returns http success, status' do
      sign_in @user
      get recipe_path(@user)
      expect(response).to be_successful
      expect(response.status).to eq(200)
    end

    it 'should render show view' do
      sign_in @user
      get recipe_path(@user)
      expect(response).to render_template(:show)
      expect(response.body).to include('Recipe')
    end
  end
end