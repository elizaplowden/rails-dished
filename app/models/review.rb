class Review < ApplicationRecord
  belongs_to :recipe
  belongs_to :user
  validates :rating, numericality: { integer_only: true }, inclusion: { in: 1..5 }
  validates :user, uniqueness: { scope: :recipe }
  validates :description, presence: true
end
