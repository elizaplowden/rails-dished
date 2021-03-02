class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  has_many :notes

  validates :recipe, uniqueness: { scope: :user }
end
