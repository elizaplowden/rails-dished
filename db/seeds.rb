# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).


puts 'deleting existing records...'
Cookbook.delete_all
Bookmark.delete_all
Review.delete_all
Note.delete_all
Ingredient.delete_all
# Recipe.delete_all
Following.delete_all
Food.delete_all
User.delete_all

###################################

puts 'creating users...'

User.create(email: 'email@gmail.com', password: 'Password1')
User.create(email: 'email@hotmail.com', password: 'Password2')
User.create(email: 'email@outlook.com', password: 'Password3')

puts "created #{User.count} users"

###################################

puts 'creating cookbooks...'

# creating a cookbook for each user
User.all.each do |user|
  Cookbook.create(user: user)
end

puts "created #{Cookbook.count} cookbooks"

###################################

# seeding the list of foods from an API
