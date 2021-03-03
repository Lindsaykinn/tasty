class Category < ApplicationRecord
  
  has_many :recipes
  has_many :instructions, through: :recipes

  validates :name, presence: true, uniqueness: true

  scope :sorted, -> { order("name asc")}

  def self.recent_category
    Category.order(created_at: :desc).limit(1)
  end

end
