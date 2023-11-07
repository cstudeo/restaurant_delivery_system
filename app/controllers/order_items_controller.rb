class OrderItemsController < ApplicationController
  before_action :set_restaurant, only: :create
  before_action :set_cart, if: :user_signed_in?
  before_action :set_customer, only: :create, if: :user_signed_in?
  
  def create
    if user_signed_in?
      @order_item = @cart.order_items.find_or_initialize_by(food_item_id: order_params[:food_item_id])

      if @order_item.new_record?
        @order_item.assign_attributes(order_params)
      else
        @order_item.quantity += 1
      end
      @order_item.save
    else
      session[:order_details] ||= []
      new_data = {
        quantity: params[:order_item][:quantity].to_i,
        food_item_id: params[:order_item][:food_item_id].to_i
      }
      
      matching_item = session[:order_details].find do |item|
        item["food_item_id"] == new_data[:food_item_id]
      end
      
      if matching_item
        matching_item["quantity"] = (matching_item["quantity"].to_i + new_data[:quantity]).to_s
      else
        session[:order_details] << new_data
      end
    end

    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def update
    if user_signed_in?
      @order_item = @cart.order_items.find(params[:id])
      if @order_item.update(quantity: params[:quantity])
        render json: { 
          quantity: @order_item.quantity, 
          id: @order_item.id, 
          item_total: @order_item.total, 
          grand_total: @cart.total_amount }
      else
        render json: { error: 'Failed to update quantity' }, status: :unprocessable_entity
      end
    else
      session[:order_details].each { |item|  item["quantity"] = params[:quantity] if item["food_item_id"].to_i == params[:id].to_i }
      render json: {  
        grand_total: total_amount_for_session }
    end
  end

  def destroy
    if user_signed_in?
      @order_item = @cart.order_items.find(params[:id])
      @order_item.destroy
      if @order_item.destroy
        render json: {
          cart_count: @cart.order_items.count, 
          grand_total: @cart.total_amount }
      else
        render json: { error: 'Failed to update quantity' }, status: :unprocessable_entity
      end
    else
      session[:order_details].delete_if { |item| item["food_item_id"] == params[:id].to_i }
      render json: {  
        grand_total: total_amount_for_session }
    end
  end

  private

  def order_params
    params.require(:order_item).permit(:food_item_id, :quantity)
  end

  def set_cart
    @cart = current_cart
  end

  def set_restaurant
    @restaurant = FoodItem.find_by(id: params[:order_item][:food_item_id]).restaurant
    session[:restaurant_id] = @restaurant.id
  end

  def set_customer
    @customer = current_user
  end
end
