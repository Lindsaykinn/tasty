class AddRecipeIdToCategory < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :recipe_id, :integer
  end
end
