class Recipe < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :ingredients, dependent: :destroy
  has_many :notes, through: :bookmarks

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :instructions, presence: true
  validates :serves, presence: true
  validates :cook_time, presence: true
  # has_many_attached :photos
end
