class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    # used in the select tag
    @foods = Food.all
  end
end
