class Food < ApplicationRecord
  has_many :ingredients
  validates :name, presence: true, uniqueness: true
end
