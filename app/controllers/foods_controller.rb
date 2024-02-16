class FoodsController < ApplicationController
  before_action :authenticate_user!

  def index
    @foods = current_user.foods
  end

  def show
    @food = current_user.foods.find(params[:id])
  end

  def new
    @food = current_user.foods.build
  end

  def create
    @food = current_user.foods.build(food_params)
    if @food.save
      redirect_to foods_path, notice: 'Food item successfully added'
    else
      render :new
    end
  end

  def destroy
    @food = current_user.foods.find(params[:id])
    @food.recipe_foods.destroy_all
    if @food.destroy
      redirect_to foods_path, notice: 'Recipe item deleted successfully.'
    else
      redirect_to foods_path, alert: 'Failed to delete the Recipe Item!'
    end
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :quantity, :price)
  end
end
