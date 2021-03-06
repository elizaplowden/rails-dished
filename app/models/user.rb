class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # array of follows for the given user instance
  has_many :follows_given, foreign_key: :follower_id, class_name: "Following"
  # array of users who follow the user instance
  has_many :follows_received, foreign_key: :followee_id, class_name: "Following"

  has_many :recipes
  has_many :reviews
  has_many :bookmarks
  has_one :cookbook
  has_many :notifications, foreign_key: :recipient_id
  validates :username, presence: true, uniqueness: true
  has_one_attached :avatar
end
