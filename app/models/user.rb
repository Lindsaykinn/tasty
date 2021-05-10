class User < ApplicationRecord
  has_secure_password
  
  has_many :recipes
  has_many :categories, through: :recipes

  has_many :comments, through: :recipes
  
  validates :name, presence: true

  validates :email, presence: true, uniqueness: true 

  def friends
    self.comments.map do |comment|
      comment.user.name
    end.uniq
  end
end
