class FoodItemsController < ApplicationController
  before_action :set_restaurant, only: %i[index]

    def index
      @food_items = @restaurant.food_items
    end

    private

    def set_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id])
    end
  end
  