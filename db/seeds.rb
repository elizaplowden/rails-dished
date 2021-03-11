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

puts 'creating users...'

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
User.create(email: 'ainsley@email.com', password: 'Password1', username: 'ainsleyh')

3.times do
  User.create(email: Faker::Internet::email, password: 'Password1', username: Faker::Internet::username)
end

puts 'attaching avatars...'

counter = 0

avatar_urls = ['https://res.cloudinary.com/dupmc3vsd/image/upload/v1615367276/diego.png',
               'https://res.cloudinary.com/dupmc3vsd/image/upload/v1615388003/jayray_oqfuxc.jpg',
               'https://res.cloudinary.com/dupmc3vsd/image/upload/v1615388003/nigella_zn2xvl.jpg',
               'https://res.cloudinary.com/dupmc3vsd/image/upload/v1615388003/casper_nocw1b.jpg',
               'https://res.cloudinary.com/dupmc3vsd/image/upload/v1615388004/gordon_kn7y8r.jpg',
               'https://res.cloudinary.com/dupmc3vsd/image/upload/v1615388003/roychoi_hkggeq.jpg',
               'https://res.cloudinary.com/dupmc3vsd/image/upload/v1615456761/michael-dam-mEZ3PoFGs_k-unsplash_d2achi.jpg',
               'https://res.cloudinary.com/dupmc3vsd/image/upload/v1615456759/ian-dooley-d1UPkiFd04A-unsplash_wssqoj.jpg',
               'https://res.cloudinary.com/dupmc3vsd/image/upload/v1615456761/pablo-merchan-montes-Orz90t6o0e4-unsplash_2_cduxzd.jpg',
               'https://res.cloudinary.com/dupmc3vsd/image/upload/v1615456763/joseph-gonzalez-iFgRcqHznqg-unsplash_mlgbn8.jpg',
               'https://res.cloudinary.com/dupmc3vsd/image/upload/v1615456757/ainsley_acq6tb.jpg'

              ]

avatar_filenames = ['diego.png',
                    'jayray_byypnd.jpg',
                    'nigella_ujmnt8.jpg',
                    'casper_jxkaje.jpg',
                    'gordon_kn7y8r.jpg',
                    'roychoi_irciqd.jpg',
                    'michael-dam-mEZ3PoFGs_k-unsplash_d2achi.jpg',
                    'ian-dooley-d1UPkiFd04A-unsplash_wssqoj.jpg',
                    'pablo-merchan-montes-Orz90t6o0e4-unsplash_2_cduxzd.jpg',
                    'joseph-gonzalez-iFgRcqHznqg-unsplash_mlgbn8.jpg',
                    'ainsley_acq6tb.jpg'
                    ]

# creating an array of the users which will get avatars
users = []
users << User.find_by(username: 'GoldenBoy')
users << User.find_by(username: 'jayray')
users << User.find_by(username: 'nigella')
users << User.find_by(username: 'chefcasper')
users << User.find_by(username: 'Gordon Ramsey')
users << User.find_by(username: 'roychoi')
users << User.find_by(username: 'saraevs')
users << User.find_by(username: 'Phillip')
users << User.find_by(username: 'Eliza')
users << User.find_by(username: 'George')
users << User.find_by(username: 'ainsleyh')




number = avatar_urls.size

number.times do
  url = avatar_urls[counter]
  downloaded_image = open(url)
  filename = File.basename(URI.parse(url).path)
  user = users[counter]
  # attaching the photo as the avatar
  user.avatar.attach(io: downloaded_image, filename: filename)
  # increment the counter!
  counter += 1
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
  'https://themealdb.com/api/json/v1/1/search.php?s=Thai%20Green%20Curry', #0
  'https://themealdb.com/api/json/v1/1/search.php?s=Banana%20Pancakes', #1
  'https://themealdb.com/api/json/v1/1/search.php?s=Mediterranean%20Pasta%20Salad', #2
  'https://themealdb.com/api/json/v1/1/search.php?s=Lamb%20Tzatziki%20Burgers', #3
  'https://themealdb.com/api/json/v1/1/search.php?s=chocolate%20souffle', #4
  'https://themealdb.com/api/json/v1/1/search.php?s=cajun%20spiced%20fish%20tacos', #5
  'https://themealdb.com/api/json/v1/1/search.php?s=Chinon%20Apple%20Tarts', #6
  'https://themealdb.com/api/json/v1/1/search.php?s=Chicken%20Quinoa%20Greek%20Salad', #7
  'https://themealdb.com/api/json/v1/1/search.php?s=Honey%20Teriyaki%20Salmon', #8
  'https://themealdb.com/api/json/v1/1/search.php?s=Lamb%20Tagine', #9
  'https://themealdb.com/api/json/v1/1/search.php?s=Tuna%20Nicoise', #10
  'https://themealdb.com/api/json/v1/1/search.php?s=Vegan%20Lasagna', #11
  'https://themealdb.com/api/json/v1/1/search.php?s=Jerk%20chicken%20with%20rice%20&%20peas', #12
  'https://themealdb.com/api/json/v1/1/search.php?s=Squash%20linguine', #13
  'https://themealdb.com/api/json/v1/1/search.php?s=carrot%20cake', #14
  'https://themealdb.com/api/json/v1/1/search.php?s=Salmon%20Prawn%20Risotto', #15
  'https://themealdb.com/api/json/v1/1/search.php?s=Baked%20salmon%20with%20fennel%20&%20tomatoes', #16
  'https://themealdb.com/api/json/v1/1/search.php?s=Grilled%20Mac%20and%20Cheese%20Sandwich', #17
  'https://themealdb.com/api/json/v1/1/search.php?s=Blackberry%20Fool' #18
]

image_url = [
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1614944353/curry_enmkfv.jpg', #0
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1614944736/pancakes_qrqfsm.jpg', #1
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1614944817/photo-1473093295043-cdd812d0e601_feew13.jpg', #2
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1614944885/burger_v3wcmm.jpg', #3
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1614945126/photo-1579523609100-5b868b803668_z4psfa.jpg', #4
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1614945367/tacos_yjk701.jpg', #5
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1614945552/apple_tart_fqencu.jpg', #6
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1614945687/quinoa_n9zmji.jpg', #7
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1614944557/salmon_xv79pu.jpg', #8
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1614945819/tagine_asyowg.jpg', #9
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1614949295/nicoise_vphbl4.jpg', #10
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1614949440/lasagne_avupin.jpg', #11
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1614949651/jerk_uywqnh.jpg', #12
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1614949851/inguine_o0jtfp.jpg', #13
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1614949946/carrot_cake_sw8lch.jpg', #14
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1615367145/salmon_prawn_risotto_iswv1q.jpg', #15
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1615367150/baked_salmon_tomatoes_vwocer.jpg', #16
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1615367152/sandwich1_i4kmqr.jpg', #17
      'https://res.cloudinary.com/dupmc3vsd/image/upload/v1615367163/blackberryfool_xkdoxb.jpg' #18
]

image_name = [
      'curry_enmkfv.jpg', #0
      'pancakes_qrqfsm.jpg', #1
      'photo-1473093295043-cdd812d0e601_feew13.jpg', #2
      'burger_v3wcmm.jpg', #3
      'photo-1579523609100-5b868b803668_z4psfa.jpg', #4
      'tacos_yjk701.jpg', #5
      'apple_tart_fqencu.jpg', #6
      'quinoa_n9zmji.jpg', #7
      'salmon_xv79pu.jpg', #8
      'tagine_asyowg.jpg', #9
      'nicoise_vphbl4.jpg', #10
      'lasagne_avupin.jpg', #11
      'jerk_uywqnh.jpg', #12
      'inguine_o0jtfp.jpg', #13
      'carrot_cake_sw8lch.jpg', #14
      'salmon_prawn_risotto_iswv1q.jpg', #15
      'baked_salmon_tomatoes_vwocer.jpg', #16
      'sandwich1_i4kmqr.jpg', #17
      'blackberryfool_xkdoxb.jpg' #18
]


19.times do
  # gets one recipe from the recipes_url array (at the index that = counter)
  recipe_serialized = open(recipes_url[counter]).read
  recipe_parsed = JSON.parse(recipe_serialized)

  # selects a random user
  rand_user = User.order("RANDOM()").limit(1).first

  recipe_parsed['meals'].each do |meal|
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
