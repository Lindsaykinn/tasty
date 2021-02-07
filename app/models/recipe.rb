class Recipe < ApplicationRecord

  belongs_to :user

  belongs_to :category
  accepts_nested_attributes_for :category, reject_if: :all_blank

  has_many :comments

  has_many :instructions, dependent: :destroy
  accepts_nested_attributes_for :instructions, reject_if: :all_blank, allow_destroy: :true 

  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  
  validates :title, presence: true


  def self.alphabetize
    order(title: :asc)
  end

end
