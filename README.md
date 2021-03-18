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
