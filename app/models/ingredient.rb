class Ingredient < ApplicationRecord
  belongs_to :food
  belongs_to :recipe

  validates :quantity, presence: true
  validates :food, uniqueness: { scope: :recipe }
end
