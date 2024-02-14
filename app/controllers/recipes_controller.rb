class RecipesController < ApplicationController
  before_action :authenticate_user!

  def index
    @recipes = current_user.recipes.includes(:user)
  end

  def show
    @recipe = Recipe.includes(:user, :food_name).find(params[:id])
  end

  def new
    @recipe = current_user.recipes.build
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      redirect_to recipes_path, notice: 'Recipe item added successfully.'
    else
      render :new
    end
  end

  def destroy
    @recipe = current_user.recipes.find(params[:id])
    @recipe.recipe_foods.destroy_all
    if @recipe.destroy
      redirect_to recipes_path, notice: 'Recipe item deleted successfully.'
    else
      redirect_to recipes_path, alert: 'Failed to delete the Recipe!'
    end
  end

  def update
    @recipe = current_user.recipes.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: 'Recipe updated successfully.'
    else
      flash.now[:alert] = 'Failed to Update the Recipe!'
      render :edit
    end
  end

  def edit
    @recipe = current_user.recipes.find(params[:id])
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :cooking_time, :preparation_time, :public)
  end
end