class Recipe < ApplicationRecord

  belongs_to :user
  belongs_to :category
  accepts_nested_attributes_for :category, reject_if: :all_blank

  has_many :instructions, dependent: :destroy
  accepts_nested_attributes_for :instructions, reject_if: :all_blank, allow_destroy: true 

  has_many :comments

  validates :title, presence: true
  validates :instructions, presence: true
  validates :description, presence: true


  scope :sorted, -> { order("title asc")}

  def category_name=(name)
    self.category = Category.find_or_create_by(name: name)
  end

  def category_name
     self.category ? self.category.name : nil
  end


  def self.search(params)
    where("LOWER(title) LIKE ?", "%#{params}%")
  end

end
