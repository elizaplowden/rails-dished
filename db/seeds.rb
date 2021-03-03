# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
require 'json'
require 'open-uri'

puts 'deleting existing records...'

Note.delete_all
Review.delete_all
Bookmark.delete_all
Ingredient.delete_all
Following.delete_all
Recipe.delete_all
Food.delete_all
User.delete_all

###################################

User.create(email: 'email@gmail.com', password: 'Password1', username: 'user3456')
User.create(email: 'email@hotmail.com', password: 'Password2', username: 'foodielondon')
User.create(email: 'email@outlook.com', password: 'Password3', username: 'chefjacob')

puts "created #{User.count} users"


###################################

# seeding the list of foods from an API
foods_url = 'https://www.themealdb.com/api/json/v1/1/list.php?i=list'
foods_serialized = open(foods_url).read
foods = JSON.parse(foods_serialized)

foods['meals'].each do |food|
  Food.create(name: food['strIngredient'])
end

puts "created #{Food.count} foods"

###################################


# seeding some recipes from meals.db api

10.times do

  recipes_url = 'https://www.themealdb.com/api/json/v1/1/random.php'
  recipes_serialized = open(recipes_url).read
  recipes = JSON.parse(recipes_serialized)


  recipes['meals'].each do |meal|
    # creating the recipe instance and saving to the db
     recipe = Recipe.create( {
      name: meal['strMeal'],
      description: 'a meal',
      instructions: meal['strInstructions'],
      serves: rand(1..10),
      cook_time: rand(15..60),
      user: User.first,
    } )
     # creating arrays of the ingredients and foods
    foods = [meal['strIngredient1'], meal['strIngredient2'], meal['strIngredient3'], meal['strIngredient4'], meal['strIngredient5']]
    measures = [meal['strMeasure1'], meal['strMeasure2'], meal['strMeasure3'], meal['strMeasure4'], meal['strMeasure5']]
    # iterating over each measure
    measures.each_with_index do |measure, index|
      # finding the food instance with the same name as the ingredient from the API
      food = Food.find_by(name: foods[index])
      # creating the ingredient instances
      Ingredient.create({
      recipe: recipe,
      food: food,
      quantity: measure
     })

     # attaching a photo to the recipe
     image_url = meal['strMealThumb']
     downloaded_image = open(image_url)
     filename = File.basename(image_url)
     recipe.photo.attach(io: downloaded_image, filename: filename)
     puts 'attached photo'
    end
  end
end

puts "created #{Recipe.count} recipes"
puts "created #{Ingredient.count} ingredients"

###################################

reviews = %w('Really tasty, I love this recipe.', 'I cooked this for my family, and they all loved it.', 'Simple and delicious meal.')

counter = 0
5.times do
  Review.create({
    rating: rand(1..5),
    description: reviews.sample,
    user: User.last,
    recipe: Recipe.last
  })
  counter += 1
end

puts "created #{counter} reviews"

###################################

follower = User.first
followee = User.last

Following.create({
  follower: follower,
  followee: followee
})

puts "created #{Following.count} followings"

###################################

  Bookmark.create({
    user: User.first,
    recipe: Recipe.first
  })

puts "created #{Bookmark.count} bookmarks"

###################################

  Note.create({
    bookmark: Bookmark.first,
    description: 'Add more salt'
  })

  Note.create({
    bookmark: Bookmark.first,
    description: 'Cook for 5 mins longer'
  })

puts "created #{Note.count} notes"
