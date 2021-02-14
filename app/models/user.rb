class User < ApplicationRecord
  has_secure_password
  
  has_many :recipes
  has_many :categories, through: :recipes
  
  validates :name, presence: true

  validates :email, presence: true, uniqueness: true 
end
