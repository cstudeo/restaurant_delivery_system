module ApplicationHelper
  def full_name
    user = current_user
    "#{user.first_name} #{user.last_name}"
  end

	def current_cart
		@cart = Cart.find_or_create_by(user_id: current_user.id)
	end

	def current_restaurant
		Restaurant.find_by_id(session[:restaurant_id])
	end

    def cart_count
      matching_order_items = session[:order_details]&.select { |order_item| (order_item[:restaurant_id] ||  order_item['restaurant_id']) == current_restaurant.id }
      user_signed_in? ? current_cart.order_items.count : (matching_order_items || []).length
    end

	def total_amount_for_session
    total = 0.to_d

    if session[:order_details]
      session[:order_details].each do |item|
        food_item = FoodItem.find_by(id: item["food_item_id"])
        
        if food_item
          unit_price = food_item.price.to_d || 0.to_d
          quantity = item["quantity"].to_i || 0
          
          total += (unit_price * quantity)
        end
      end
    end
    
    total
	end

  def eligible_carriers
    today = Date.today
    eligible_carriers = Carrier.is_available.select do |carrier|
      carrier.orders.where('DATE(created_at) = ?', today).count < 10
    end

    eligible_carriers.sample
  end

	def cart_total
		user_signed_in? ? current_cart.total_amount : total_amount_for_session
	end
end
