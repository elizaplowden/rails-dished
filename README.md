# Dished!

Dished! is a web application that allows users to search for multiple ingredients and find inspiration for recipes to cook.

## Live website

You can check out the live web application here:
https://www.dished.site/

## Tech

Rails app generated with [lewagon/rails-templates](https://github.com/lewagon/rails-templates), created by the [Le Wagon coding bootcamp](https://www.lewagon.com) team.

Hosted on heroku.

## Running locally

Clone the github repo locally, and navigate to that folder in your terminal.
Run the below commands in your terminal to install all the ruby gems, install the js, create the db and populate it with test data, and lastly start a server locally.

``` 
bundle install
yarn install
rails db:migrate
rails db:seed
rails s
```

Then go to http://localhost:3000/ to view this application in your browser.

## About the App

Dished! is a recipe inspiration application where users have their own profile pages and personal 'Cookbooks'. The main feature of the website is the search bar, which users can use to find a recipe to cook with things already in their fridge, avoiding food waste and saving money. They can save recipes into their 'Dishlist' to narrow down options, and then add recipes from their Dishlist to their personal cookbooks on their profile page. Users can also follow their friends and favourite chefs and find inspiration on others' profiles. Dished! has a notification feature, so users are updated when people follow them or when those they follow have shared a new recipe. Users can also upload photos of recipes after cooking them, rate recipes, and add personal notes to their 'bookmarked' recipes (which only they can see).

The screenshots below display several of the main features:

Homepage:
- The homepage has an automatic carousel which slides dynamically between two background images.

![Screenshot](https://user-images.githubusercontent.com/71760740/123434667-a4325380-d5c4-11eb-87a6-76d9a8477d83.png)
![Screenshot](https://user-images.githubusercontent.com/71760740/123434798-c4faa900-d5c4-11eb-953e-ab47754d933c.png)
