class RecipesController < ApplicationController
  before_action :redirect_if_not_logged_in
  before_action :find_recipe, only: [:show, :edit, :update, :destroy]
  before_action :find_category, only: [:index, :new, :create]

  def index
    @recipes = Recipe.all
    if @category
      @recipes = @category.recipes 
    else
      @recipes = Recipe.all.alphabetize
    end
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      if @category
        redirect_to category_recipes_path(@category) 
      else
        redirect_to recipes_path
      end
    else
      flash.now[:error] = @recipe.errors.full_messages
      if @category 
        render :new_category_recipe
      else
        render :new
      end
    end
  end

  private

  def find_recipe
    @recipe = Recipe.find_by_id(params[:id])
  end

  def find_category
    if params[:category_id]
      @category = Category.find_by_id(params[:id])
    end
  end

  def recipe_params
    params.require(:recipe).permit(
    :title, 
    :description, 
    instructions_attributes: [:id, :step, :_destroy]
  )
  end

end
