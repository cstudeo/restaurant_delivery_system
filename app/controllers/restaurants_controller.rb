class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
    # byebug
    # Paystack.new("pk_test_deebbde4eab19e1f1dd98af8f68c04553d379249", "sk_test_REDACTED")
  end
end
