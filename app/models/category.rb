class Category < ApplicationRecord
  belongs_to :user, optional: true
  has_many :recipes 
  has_many :instructions, through: :recipes

  validates :name, presence: true, uniqueness: true

  scope :sorted, -> { order("name asc")}

end
