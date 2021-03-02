# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'deleting existing records...'
Cookbook.delete_all
Bookmark.delete_all
Following.delete_all
Food.delete_all
Ingredient.delete_all
Note.delete_all
Recipe.delete_all
Review.delete_all
User.delete_all


puts 'creating users...'

User.create(email: 'email@gmail.com', password: 'Password1')
User.create(email: 'email@hotmail.com', password: 'Password2')

puts "created #{User.count} users"


