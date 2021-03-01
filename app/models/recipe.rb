class Recipe < ApplicationRecord
  belongs_to :user
  has_many :reviews, :bookmarks, dependent: :destroy
  has many :ingredients
  validates :name, :description, :instructions, :serves, :cook_time, presence: true
  # has_many_attached :photos
end
