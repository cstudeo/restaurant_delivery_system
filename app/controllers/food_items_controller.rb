class FoodItemsController < ApplicationController
  before_action :set_restaurant, only: %i[index]

  def index
    @food_items = @restaurant.food_items
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end
end
  