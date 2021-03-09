require 'json'
require 'open-uri'
require 'faker'

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


User.create(email: 'goldenboy@gmail.com', password: 'goldenboy', username: 'GoldenBoy')
User.create(email: 'gordon@kitchennightmares.com', password: 'gordon', username: 'Gordon Ramsey')
User.create(email: 'jayray@gmail.com', password: 'jayray', username: 'jayray')
User.create(email: 'saraevs@email.com', password: 'Password1', username: 'saraevs')
User.create(email: 'phillip@email.com', password: 'Password1', username: 'Phillip')
User.create(email: 'eliza@email.com', password: 'Password1', username: 'Eliza')
User.create(email: 'george@email.com', password: 'Password1', username: 'George')
User.create(email: 'chefcasper@email.com', password: 'Password1', username: 'chefcasper')
User.create(email: 'nigella@email.com', password: 'Password1', username: 'nigella')
User.create(email: 'roy@email.com', password: 'Password1', username: 'roychoi')


3.times do
  User.create(email: Faker::Internet::email, password: 'Password1', username: Faker::Internet::username)
end

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
  'https://themealdb.com/api/json/v1/1/search.php?s=carrot%20cake',
  'https://www.themealdb.com/api/json/v1/1/search.php?s=Salmon%20Prawn%20Risotto',
  'https://www.themealdb.com/api/json/v1/1/search.php?s=Baked%20salmon%20with%20fennel%20&%20tomatoes',
  'https://themealdb.com/api/json/v1/1/search.php?s=Lasagne',
  'https://themealdb.com/api/json/v1/1/search.php?s=Blackberry%20Fool'
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
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1614949946/carrot_cake_sw8lch.jpg',
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1614949946/carrot_cake_sw8lch.jpg',
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1614949946/carrot_cake_sw8lch.jpg',
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1614949946/carrot_cake_sw8lch.jpg',
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
      'carrot_cake_sw8lch.jpg',
      'carrot_cake_sw8lch.jpg',
      'carrot_cake_sw8lch.jpg',
      'carrot_cake_sw8lch.jpg',
      'carrot_cake_sw8lch.jpg'
]


19.times do
  recipes_serialized = open(recipes_url[counter]).read
  recipes = JSON.parse(recipes_serialized)

  # selects a random user
  rand_user = User.order("RANDOM()").limit(1).first

  recipes['meals'].each do |meal|
    # creating the recipe instance and saving to the db
     recipe = Recipe.create( {
      name: meal['strMeal'],
      description: 'a meal',
      instructions: meal['strInstructions'],
      serves: rand(1..10),
      cook_time: rand(15..60),
      cuisine: ["Indian", "Italian", "French", "British", "Chinese", "Austrian"].sample,
      user: rand_user
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
   puts "created recipe #{counter + 1}"
   counter += 1
end

puts "created #{Recipe.count} recipes"
puts "created #{Ingredient.count} ingredients"

###################################

good_reviews = ['Really tasty, I love this recipe.',
          'I cooked this for my family, and they all loved it.',
          'Simple and delicious meal.',
          'Definitely going to make this again, it was delicious.',
          'SOOOOOOOOO TASTY!!!!',
          'Dished is the best website, I love this recipe!',
          'I loved the recipe, but it makes way too much! I couldnt eat it all.',
          'Lovely meal',
          'I really enjoyed this.',
          'Cooked this recently, great as a mid-week meal.',
          'I want to eat this all the time!!!!',
          'Better than a restaurant',
          'I love Dished, their recipes are always amazing. This is another winner.'
          ]

counter = 0
recipes = Recipe.all

# creating a good review for every recipe
recipes.each do |recipe|
  random_user = User.order("RANDOM()").limit(1).first

  Review.create({
    rating: rand(4..5),
    description: good_reviews[counter],
    user: random_user,
    recipe: recipe
  })
  counter += 1
end

counter = 0

# creating 5 random bad reviews
bad_reviews = ['I hate this.', 'Won\t cook this again', 'Pretty bland, but was ok once I added some spices', 'Loved it, but it makes way too much, I couldn\'t eat it all!']
5.times do
  random_user = User.order("RANDOM()").limit(1).first
  random_recipe = Recipe.order("RANDOM()").limit(1).first

  Review.create({
    rating: rand(2..3),
    description: bad_reviews.sample,
    user: random_user,
    recipe: random_recipe
  })
  counter += 1
end

puts "created #{Review.count} reviews"

###################################


follower = User.find_by(username: 'GoldenBoy')
followees = []
followees << User.find_by(username: 'GordonRamsey')
followees << User.find_by(username: 'jayray')
followees << User.find_by(username: 'saraevs')

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
