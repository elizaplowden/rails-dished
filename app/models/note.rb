class Note < ApplicationRecord
  belongs_to :bookmark
  validates :description, presence: true
end
