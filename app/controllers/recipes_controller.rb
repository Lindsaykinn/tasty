class RecipesController < ApplicationController
  #need before_action find_recipe here

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
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      render :new
    end
  end
end
