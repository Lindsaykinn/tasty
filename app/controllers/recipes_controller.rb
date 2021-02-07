class RecipesController < ApplicationController
  before_action :redirect_if_not_logged_in
  before_action :find_recipe, only: [:show, :edit, :update, :destroy]
  before_action :find_category, only: [:index, :new, :create]

  def index
    @recipes = Recipe.all
    if @category
      @recipes = @category.recipes 
    else
      @recipes = Recipe.all
    end
  end

  def new
    @recipe = Recipe.new
    @recipe.recipe_ingredients.build
  end

  def create
    params[:recipe][:user_id] = current_user.id
    @recipe = Recipe.new(recipe_params)
      if @recipe.save
        redirect_to recipe_path(@recipe)
      else
        flash.now[:error] = @recipe.errors.full_messages
        render :new        
      end
  end

  def show
    if @category
      redirect_to category_recipe_path(@category)
    end
  end

  def edit
    
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe)
    else
      flash.now[:error] = @recipe.errors.full_messages
      render :edit
    end
  end

  def destroy
    @recipe.destroy
    flash.now[:notice] = "Recipe has been deleted."
    redirect_to recipes_path
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
    :user_id,
    :category_id,
    instructions_attributes: [
      :id, 
      :step, 
      :_destroy],
    recipe_ingredients_attributes: [
      :measurement,
      ingredient_attributes: [
        :ingredient_name
      ]
    ]
  )
  end

end
