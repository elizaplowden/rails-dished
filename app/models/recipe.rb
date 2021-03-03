class Recipe < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :ingredients, dependent: :destroy
  has_many :foods, through: :ingredients

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :instructions, presence: true
  validates :serves, presence: true
  validates :cook_time, presence: true
  # has_many_attached :photos

  include PgSearch::Model
  pg_search_scope :search_by_food,
                  associated_against: { foods: :name },
                  using: { tsearch: { prefix: true } }
end
