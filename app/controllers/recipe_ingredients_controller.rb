class RecipeIngredientsController < ApplicationController
  before_action :redirect_if_not_logged_in
  before_action :find_recipe

  def index
    find_recipe
  end

  def new
    @ingredient = Ingredient.new
    @ingredients = Ingredient.all

    if @recipe 
      @recipe_ingredient = @recipe.recipe_ingredients.new
    else
      @recipe_ingredient = RecipeIngredient.new
    end   
  end

  def create
    if select_and_create_ingredient
      flash[:error] = "Must select OR create."
      @recipe_ingredient = RecipeIngredient.new
      @recipe_ingredient.recipe_id = params[:recipe_id]
      @ingredient = Ingredient.new
      render :new and return
    end
    @recipe_ingredient = RecipeIngredient.create(recipe_ingredient_params)

    if create_ingredient
      Ingredient.create(recipe_ingredient_params[:ingredient_attributes])
    else
      @recipe_ingredient.ingredient = Ingredient.find_by_id(recipe_ingredient_params[:ingredient_id])
    end

    if @recipe_ingredient.save
      redirect_to recipe_path(@recipe_ingredient.recipe_id)
    else
      render :new
    end
  end

def delete_selected
  if params[:recipe_ingredients]
    RecipeIngredient.destroy(params[:recipe_ingredients])
    @recipe = params[:recipe_id]
    redirect_to recipe_path(@recipe)
  end
end



private

def recipe_ingredient_params 
  params.require(:recipe_ingredient).permit(:recipe_id, :ingredient_id, :measurement, ingredient_attributes: [:ingredient_name])

  def find_recipe
    @recipe = Recipe.find_by_id(params[:recipe_id])
  end

  def select_and_create_ingredient
    recipe_ingredient_params[:ingredient.id] != "" && recipe_ingredient_params[:ingredient_attributes][:ingredient_name] != ""
  end

  def create_ingredient
    recipe_ingredient_params[:ingredient:id] == ""
  end
end
