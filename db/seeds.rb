# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
require 'json'
require 'open-uri'

puts 'deleting existing records...'

#  remove the session before destroying all the records
# session = nil
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
User.create(email: 'goldenboy@gmail.com', password: 'goldenboy', username: 'GoldenBoy')

puts "created #{User.count} users"


###################################

# seeding the list of foods from an API
foods_url = 'https://www.themealdb.com/api/json/v1/1/list.php?i=list'
foods_serialized = open(foods_url).read
foods = JSON.parse(foods_serialized)

foods['meals'].each do |food|
  Food.create(name: food['strIngredient'].downcase)
end

puts "created #{Food.count} foods"

###################################


# seeding some recipes from meals.db api
puts 'creating recipes, ingredients and photos...'
counter = 0
recipes_url = [
  'https://themealdb.com/api/json/v1/1/search.php?s=Thai%20Green%20Curry',
  'https://themealdb.com/api/json/v1/1/search.php?s=Banana%20Pancakes',
  'https://themealdb.com/api/json/v1/1/search.php?s=Mediterranean%20Pasta%20Salad',
  'https://themealdb.com/api/json/v1/1/search.php?s=Lamb%20Tzatziki%20Burgers',
  'https://themealdb.com/api/json/v1/1/search.php?s=chocolate%20souffle',
  'https://themealdb.com/api/json/v1/1/search.php?s=cajun%20spiced%20fish%20tacos',
  'https://themealdb.com/api/json/v1/1/search.php?s=Chinon%20Apple%20Tarts',
  'https://themealdb.com/api/json/v1/1/search.php?s=Chicken%20Quinoa%20Greek%20Salad',
  'https://themealdb.com/api/json/v1/1/search.php?s=Honey%20Teriyaki%20Salmon',
  'https://themealdb.com/api/json/v1/1/search.php?s=Lamb%20Tagine',
  'https://themealdb.com/api/json/v1/1/search.php?s=Tuna%20Nicoise',
  'https://themealdb.com/api/json/v1/1/search.php?s=Vegan%20Lasagna',
  'https://themealdb.com/api/json/v1/1/search.php?s=Jerk%20chicken%20with%20rice%20&%20peas',
  'https://themealdb.com/api/json/v1/1/search.php?s=Squash%20linguine',
  'https://themealdb.com/api/json/v1/1/search.php?s=carrot%20cake'
]
image_url = [
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1614944353/curry_enmkfv.jpg',
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1614944736/pancakes_qrqfsm.jpg',
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1614944817/photo-1473093295043-cdd812d0e601_feew13.jpg',
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1614944885/burger_v3wcmm.jpg',
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1614945126/photo-1579523609100-5b868b803668_z4psfa.jpg',
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1614945367/tacos_yjk701.jpg',
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1614945552/apple_tart_fqencu.jpg',
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1614945687/quinoa_n9zmji.jpg',
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1614944557/salmon_xv79pu.jpg',
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1614945819/tagine_asyowg.jpg',
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1614949295/nicoise_vphbl4.jpg',
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1614949440/lasagne_avupin.jpg',
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1614949651/jerk_uywqnh.jpg',
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1614949851/inguine_o0jtfp.jpg',
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1614949946/carrot_cake_sw8lch.jpg'
]

image_name = [
      'curry_enmkfv.jpg',
      'pancakes_qrqfsm.jpg',
      'photo-1473093295043-cdd812d0e601_feew13.jpg',
      'burger_v3wcmm.jpg',
      'photo-1579523609100-5b868b803668_z4psfa.jpg',
      'tacos_yjk701.jpg',
      'apple_tart_fqencu.jpg',
      'quinoa_n9zmji.jpg',
      'salmon_xv79pu.jpg',
      'tagine_asyowg.jpg',
      'nicoise_vphbl4.jpg',
      'lasagne_avupin.jpg',
      'jerk_uywqnh.jpg',
      'inguine_o0jtfp.jpg',
      'carrot_cake_sw8lch.jpg'

]


15.times do
  recipes_serialized = open(recipes_url[counter]).read
  recipes = JSON.parse(recipes_serialized)

  recipes['meals'].each do |meal|
    # creating the recipe instance and saving to the db
     recipe = Recipe.create( {
      name: meal['strMeal'],
      description: 'a meal',
      instructions: meal['strInstructions'],
      serves: rand(1..10),
      cook_time: rand(15..60),
      cuisine: ["Indian","Italian","French","British","Chinese"].sample,
      user: User.first
    } )
     # creating arrays of the ingredients and foods
     # only adds the first 5 ingredients of 20
    foods = [meal['strIngredient1'], meal['strIngredient2'], meal['strIngredient3'], meal['strIngredient4'], meal['strIngredient5'], meal['strIngredient6'], meal['strIngredient7'], meal['strIngredient8'], meal['strIngredient9'], meal['strIngredient10']]
    measures = [meal['strMeasure1'], meal['strMeasure2'], meal['strMeasure3'], meal['strMeasure4'], meal['strMeasure5'], meal['strMeasure6'], meal['strMeasure7'], meal['strMeasure8'], meal['strMeasure9'], meal['strMeasure10']]
    # iterating over each measure
    measures.each_with_index do |measure, index|
      unless measure.nil?
        # finding the food instance with the same name as the ingredient from the API
        food = Food.find_by(name: foods[index].downcase)
        # creating the ingredient instances
        Ingredient.create({
          recipe: recipe,
          food: food,
          quantity: measure
        })
      end
    end
   # attaching a photo to the recipe
   downloaded_image = open(image_url[counter])
   filename = image_name[counter]
   recipe.photo.attach(io: downloaded_image, filename: filename)
   puts 'attached photo'
  end
   puts "created recipe #{counter}"
   counter += 1
end

puts "created #{Recipe.count} recipes"
puts "created #{Ingredient.count} ingredients"

###################################

reviews = %w('Really tasty, I love this recipe.', 'I cooked this for my family, and they all loved it.', 'Simple and delicious meal.')

counter = 0

recipes = []
recipes << Recipe.find_by(name: 'Banana Pancakes')
recipes << Recipe.find_by(name: 'Thai Green Curry')
recipes << Recipe.find_by(name: 'Lamb Tagine')
recipes << Recipe.find_by(name: 'Vegan lasagne')
recipes << Recipe.find_by(name: 'Chinon Apple Tarts')

5.times do
  Review.create({
    rating: rand(3..5),
    description: reviews.sample,
    user: User.find_by(username: 'GoldenBoy'),
    recipe: recipes.sample
  })
  counter += 1
end

puts "created #{counter} reviews"

###################################


follower = User.find_by(username: 'GoldenBoy')
followees = []
followees << User.find_by(username: 'user3456')
followees << User.find_by(username: 'chefjacob')
followees << User.find_by(username: 'foodielondon')

followees.each do |followee|
  Following.create({
    follower: follower,
    followee: followee
  })
end

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
