class Cookbook < ApplicationRecord
  belongs_to :user
  has_many :bookmarks
  has_many :recipes, through: :bookmarks
end
