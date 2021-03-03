class RecipesController < ApplicationController
  before_action :redirect_if_not_logged_in
  before_action :find_recipe, only: [:show, :edit, :update, :destroy]
  before_action :redirect_if_not_owner, only: [:edit, :update, :destroy]
  before_action :find_category, only: [:index, :new, :create]

  def index
    @recipes = Recipe.all.sorted 
    if !params[:q].blank?
      @recipes = @recipes.search(params[:q].downcase)
    end
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
      if @recipe.save
        # if @category
        #   redirect_to category_recipes_path(@category) 
        # else
          redirect_to recipes_path
        # end
      else
        flash.now[:error] = @recipe.errors.full_messages
        # if @category 
        # render :new_category_recipe
        # else
        render :new
        # end
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
    # if current_user.id != @recipe.user_id
    #   flash.now[:notice] = "You cannot update a recipe that you did not author."
    #   redirect_to recipes_path
    # else
      if @recipe.update(recipe_params)
        flash[:notice] = "#{@recipe.title} has been updated."
        redirect_to recipe_path(@recipe)
      else
        flash[:error] = @recipe.errors.full_messages 
        render :edit
      end
    # end
  end

  def destroy
    if current_user.id != @recipe.user_id
      flash[:error] = @recipe.errors.full_messages
      redirect_to recipes_path
    else
      @recipe.destroy
      flash[:notice] = "#{@recipe.title} has been deleted."
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
  end
  
  def redirect_if_not_owner
    unless current_user == @recipe.user 
      redirect_to recipes_path
      flash[:error] = ["No."]
    end
  end



  def recipe_params
    params.require(:recipe).permit(
    :title, 
    :description,
    :category_name, 
    :content,
    :category_id,
    :user_id,
    # category_attributes: [:name],
    instructions_attributes: [:id,
      :step, :_destroy
      ],
    ingredients_attributes: [:id,
      :ingredient_name, :_destroy]
  )
  end

end
