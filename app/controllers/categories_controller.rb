class CategoriesController < ApplicationController
    before_action :redirect_if_not_logged_in
    before_action :find_category, only: [:show, :edit, :update, :destroy]
    
  
    def index
      @categories = Category.all
    end
  
    def new
      @category = Category.new
  
    end
  
    def create
      params[:category][:user_id] = current_user.id
      @category = Category.new(category_params)
  
      if @category.save
        redirect_to categories_path
      else
        flash.now[:error] = @category.errors.full_messages
        render :new
      end
    end
  
    def show
      @category = Category.find_by_id(params[:id])
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

    def category_params
      params.require(:category).permit(:name)
    end
end
