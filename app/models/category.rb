class Category < ApplicationRecord
  has_many :recipes 

  validates :name, presence: true

  scope :sorted, -> { order("name asc")}

end
