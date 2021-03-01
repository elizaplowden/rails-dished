class Bookmark < ApplicationRecord
  belongs_to :cookbook
  belongs_to :recipe
  has_many :notes
end
