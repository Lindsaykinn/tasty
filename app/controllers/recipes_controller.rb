class RecipesController < ApplicationController
  before_action :redirect_if_not_logged_in
  before_action :find_recipe, only: [:show, :edit, :update, :destroy]
  before_action :find_category, only: [:index, :new, :create]
  # before_action :redirect_if_not_owner, only: [:edit, :update]

  def index
    @recipes = Recipe.all
    if @category
      @recipes = @category.recipes 
    else
      @recipes = Recipe.all.sorted
    end
    if !params[:q].blank?
      @recipes = @recipes.search(params[:q].downcase)
    end
  end

  def new
    @recipe = Recipe.new
    # @recipe.instructions.build
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.category.user = current_user
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

  def show
    @category = Category.find_by_id(params[:id])
    @category = @recipe.category
  end

  def user_recipes
    @recipes = current_user.recipes 
  end

  def edit
    
  end

  def update
    if current_user.id != @recipe.category.user_id
      redirect_to recipes_path
      flash.now[:error] = "You cannot update a recipe that you did not author."
    else
      if @recipe.update(recipe_params)
        flash.now[:error] = "#{@recipe.title} has been updated."
        redirect_to recipe_path(@recipe)
      else
        flash.now[:error] = @recipe.errors.full_messages 
        redirect_to recipes_path
      end
    end
  end

  def destroy
    if current_user.id != @recipe.category.user_id
      flash.now[:error] = @recipe.errors.full_messages
      redirect_to recipes_path
    else
      @recipe.destroy
      flash.now[:notice] = "#{@recipe.title} has been deleted."
      redirect_to recipes_path    
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
  
  # def redirect_if_not_owner
  #   if current_user.id != @recipe.category.user
  #     flash[:notice] = "You cannot delete or update a recipe if you are not the owner."
  #     return redirect_to recipe_path unless @recipe 
  #     redirect_to recipe_path unless current_user.id == @recipe.category.user_id
  #     end
  #   end   
  end



  def recipe_params
    params.require(:recipe).permit(
    :title, 
    :description,
    :category_id,
    category_attributes: [:name],
    instructions_attributes: [:id,
      :step, :_destroy
      ]    
  )
  end

end
