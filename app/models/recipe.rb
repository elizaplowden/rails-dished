class Recipe < ApplicationRecord
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :ingredients, dependent: :destroy
  has_many :foods, through: :ingredients
  has_many :notes, through: :bookmarks

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :instructions, presence: true
  validates :serves, presence: true
  validates :cook_time, presence: true
  has_one_attached :photo
  has_many_attached :images

  # accepts_nested_attributes_for :ingredients, reject_if: proc { |attributes| attributes.all? { |key, value| key == "_destroy" || value.blank? } }

  include PgSearch::Model
  pg_search_scope :search_by_food,
                  associated_against: { foods: :name },
                  using: { tsearch: { prefix: true, any_word: false } }
end
