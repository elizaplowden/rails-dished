class Cookbook < ApplicationRecord
  belongs_to :user
  has_many :bookmarks
end
