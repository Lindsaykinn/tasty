class Category < ApplicationRecord
  has_many :recipes 
  belongs_to :user
  has_many :instructions, through: :recipes

  validates :name, presence: true

  scope :sorted, -> { order("name asc")}

end
