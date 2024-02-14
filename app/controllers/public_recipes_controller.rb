class PublicRecipesController < ApplicationController
    def index
      @public_recipes = Recipe.where(public: true).includes(recipe_foods: :food_name)
    end
  
    def show
      @recipe = Recipe.includes(:user, :food_name).find(params[:id])
      @user = @recipe.user
      @foods = @recipe.food_name
    end
  end