class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :recipe_id
      t.integer :user_id

      t.timestamps
    end
  end
end
