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

Index:
- The Pinterest-inspired index page was built using CSS grid
- The user can filter by ingredient or cuisine
- The recipe name and rating appear on hover

![Screenshot](https://user-images.githubusercontent.com/71760740/123435411-77327080-d5c5-11eb-99c9-6a9b6df16347.png)
![Screenshot](https://user-images.githubusercontent.com/71760740/123435430-7a2d6100-d5c5-11eb-8746-1ed74fe0aaa7.png)

Search:
- A user can search for a recipe from any page. 
- The search bar is centered on the homepage, and appears in the navbar on the other pages
- The search feature uses PG Search, Simple Form and the Select2 plugin
- A user can also filter by cuisine

![Screenshot](https://user-images.githubusercontent.com/71760740/123440006-3be67080-d5ca-11eb-92a7-5d12cded9b88.png)
![Screenshot](https://user-images.githubusercontent.com/71760740/123440027-4143bb00-d5ca-11eb-8fad-f754f21cdfbe.png)
![Screenshot](https://user-images.githubusercontent.com/71760740/123440035-443eab80-d5ca-11eb-841a-6e7c25b66f83.png)

Dishlist:
- The user can save recipes in their dishlist to consider cooking
- The Dishlist is an opaque modal which pops up on top of the current page
- The user can scroll through the carousel of recipes they've saved
- The Dishlist button has position:fixed and appears on every page except the homepage, provided a user is signed in

![Screenshot](https://user-images.githubusercontent.com/71760740/123436617-b57c5f80-d5c6-11eb-8b77-e046148a8e85.png)
![Screenshot](https://user-images.githubusercontent.com/71760740/123436624-b7462300-d5c6-11eb-89f7-c734132d534a.png)
![Screenshot](https://user-images.githubusercontent.com/71760740/123436630-b8775000-d5c6-11eb-8d72-4051603e5f4b.png)

Show Page
- The simple design on the recipe show page makes it easy for a user to read the recipe's ingredients and method
- As the user scrolls down the page, they can upload their own images and add a review
- The user can also add their own notes to a recipe, which will only be visible to them

![Screenshot](https://user-images.githubusercontent.com/71760740/123436951-12781580-d5c7-11eb-9c86-a16500013095.png)
![Screenshot](https://user-images.githubusercontent.com/71760740/123436957-13a94280-d5c7-11eb-9ea1-7266f42164ef.png)
![Screenshot](https://user-images.githubusercontent.com/71760740/123437489-9fbb6a00-d5c7-11eb-9765-33899c458d0b.png)

Cookbook
- A user can easily add a recipe to their cookbook, either from the Dishlist modal or the recipe show page
- When a recipe has been added to a cookbook, the bookmark icon is filled in on the recipe image
- The cookbook is stored on the user's profile page, where they can differentiate between recipes they've saved and those they've uploaded themselves
- A user can also view other users' personal cookbooks

![Screenshot](https://user-images.githubusercontent.com/71760740/123438391-8cf56500-d5c8-11eb-973e-b0f973e6f979.png)
![Screenshot](https://user-images.githubusercontent.com/71760740/123438389-8c5cce80-d5c8-11eb-9f44-3146673d136f.png)
![Screenshot](https://user-images.githubusercontent.com/71760740/123438520-ab5b6080-d5c8-11eb-91eb-bd76eebfc3b1.png)
![Screenshot]()
![Screenshot]()

Explore page
- A user can find their friends and favourite chefs in the Explore page
- They can see which recipes other users have uploaded and how many stars they have by scrolling through the carousel

![Screenshot](https://user-images.githubusercontent.com/71760740/123438606-c5953e80-d5c8-11eb-8a4b-754d8c22be72.png)
![Screenshot](https://user-images.githubusercontent.com/71760740/123438608-c6c66b80-d5c8-11eb-8922-2560466d86c2.png)

Notifications
- A user recieves notifications each time someone follows them or when someone they follow uploads a new recipe

![Screenshot](https://user-images.githubusercontent.com/71760740/123438848-068d5300-d5c9-11eb-9d56-e3e0dc039caa.png)

About
- A simple page with information about the project and the four developers who worked on it

![Screenshot](https://user-images.githubusercontent.com/71760740/123440314-8bc53780-d5ca-11eb-84a2-39c685fd8606.png)
