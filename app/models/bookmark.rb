class Bookmark < ApplicationRecord
  belongs_to :cookbook
  belongs_to :recipe
end
