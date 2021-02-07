class Recipe < ApplicationRecord

  belongs_to :category, optional: true
  accepts_nested_attributes_for :category, reject_if: :all_blank

  has_many :instructions, dependent: :destroy
  accepts_nested_attributes_for :instructions, reject_if: :all_blank, allow_destroy: true 


  validates :title, presence: true
  validates :instructions, presence: true
  validates :description, presence: true


  scope :sorted, -> { order("title asc")}

  

end
