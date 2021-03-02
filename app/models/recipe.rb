class Recipe < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :ingredients
  validates :name, presence: true, uniqueness: true
  validates :description, :instructions, :serves, :cook_time, presence: true
  # has_many_attached :photos
end
