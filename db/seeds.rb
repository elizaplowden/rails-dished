# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
require 'json'
require 'open-uri'

puts 'deleting existing records...'
Cookbook.delete_all
Bookmark.delete_all
Review.delete_all
Note.delete_all
Ingredient.delete_all
Following.delete_all
Recipe.delete_all
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

foods_url = 'https://www.themealdb.com/api/json/v1/1/list.php?i=list'
foods_serialized = open(foods_url).read
foods = JSON.parse(foods_serialized)

puts 'creating foods ...'

foods['meals'].each do |food|
  Food.create(name: food['strIngredient'])
end

puts "created #{Food.count} foods"

###################################


# seeding some recipes from meals.db api

recipes_url = 'https://www.themealdb.com/api/json/v1/1/random.php'
recipes_serialized = open(recipes_url).read
recipes = JSON.parse(recipes_serialized)

puts 'creating recipes ...'

recipes['meals'].each do |meal|
  # creating the recipe instance and saving to the db
   recipe = Recipe.create( {
    name: meal['strMeal'],
    description: 'a meal',
    instructions: meal['strInstructions'],
    serves: rand(1..10),
    cook_time: rand(15..60),
    user: User.first
  } )

   # creating arrays of the ingredients and foods
   foods = [meal['strIngredient1'], meal['strIngredient2'], meal['strIngredient3'], meal['strIngredient4'], meal['strIngredient5']]
   measures = [meal['strMeasure1'], meal['strMeasure2'], meal['strMeasure3'], meal['strMeasure4'], meal['strMeasure5']]

  measures.each_with_index do |measure, index|
    food = Food.find_by(name: foods[index])

    Ingredient.create({
    recipe: recipe,
    food: food,
    quantity: measure
   })

  end


end

puts "created #{Recipe.count} recipes"
puts "created #{Ingredient.count} ingredients"
