class Recipe < ApplicationRecord

  belongs_to :user

  belongs_to :category, optional: true
  accepts_nested_attributes_for :category, reject_if: :all_blank

  has_many :instructions, dependent: :destroy
  accepts_nested_attributes_for :instructions, reject_if: :all_blank, allow_destroy: true 

  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  accepts_nested_attributes_for :recipe_ingredients

  validates :title, presence: true
  validates :instructions, presence: true
  validates :description, presence: true


  scope :alphabetize, -> { order("title asc")}

  

end
