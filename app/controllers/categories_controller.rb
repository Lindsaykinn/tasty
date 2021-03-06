class CategoriesController < ApplicationController
    before_action :redirect_if_not_logged_in
    before_action :find_recipe, only: [:index, :new, :create, :edit, :update]
    before_action :find_category, only: [:edit, :update, :destroy, :create]
    

    def recent_category
      @categories = Category.recent_category
      render :index
    end
  
    def index
      @categories = Category.all.sorted
    end
  
    def new
      if @recipe
        @recipe = @category.recipes.build
        render :new_recipe_category
      else
        @category = Category.new
      end
        @category.recipes.build  
    end
  
    def create     
      @category = Category.new(category_params)
  
      if @category.save
        # if @recipe 
        #   redirect_to recipe_categories_path(@recipe)
        # else
          redirect_to categories_path
        # end
      # else
        flash.now[:error] = @category.errors.full_messages
        # if @recipe 
        #   render :new_recipe_category
        else
          render :new
        # end
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
      # if @category.recipe
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
      params.require(:category).permit(:name)
    end
end
