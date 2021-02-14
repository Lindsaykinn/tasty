class CategoriesController < ApplicationController
    before_action :redirect_if_not_logged_in
    before_action :find_recipe, only: [:index, :new, :create, :edit, :update]
    before_action :find_category, only: [:edit, :update, :destroy, :create]
    
  
    def index
      @categories = Category.all.sorted
    end
  
    def new
      if @recipe
        @recipe = @category.recipes.build
        render :new_recipe_category
      else
        @category = Category.new
        @category.recipes.build  
      end
    end
  
    def create     
      @category = Category.new(category_params)
      @category.user = current_user
      # params[:category][:user_id] = current_user.id
  
      if @category.save
        if @recipe 
          redirect_to recipe_categories_path(@recipe)
        else
          redirect_to categories_path
        end
      else
        flash.now[:error] = @category.errors.full_messages
        if @recipe 
          render :new_recipe_category
        else
          render :new
        end
      end
    end
  
    def show
      @category = Category.find_by_id(params[:id])
      @recipes = @category.recipes
    end
  
    def edit
      
    end
  
    def update
      if @category.update(category_params)
        redirect_to category_path(@category)
      else
        flash.now[:error] = @category.errors.full_messages
        render :edit
      end
    end
  
    def destroy
      # if @category
      @category.destroy
      flash[:notice] = "#{@category.name} was deleted."
      redirect_to category_path
      # elsif @category.recipe
      #   flash[:notice] = "#{@category.name} is associated with an existing recipe and cannot be deleted."
      # end
    end
  
    private
  
  
  
    def find_category
      @category = Category.find_by_id(params[:id])
    end

    def find_recipe
      if params[:recipe_id]
        @recipe = Recipe.find_by_id(params[:recipe_id])
      end
    end

    def category_params
      params.require(:category).permit(:name, :user_id, recipes_id:[])
    end
end
