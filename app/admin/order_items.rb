ActiveAdmin.register OrderItem do

  menu parent: 'ORDERS', label: 'ORDER ITEMS'

  actions :all, except: [:new, :show, :edit]

  # filter :order
  filter :created_at
  filter :order, as: :select, collection: Order.all.map { |order| ["order##{order.id}", order.id] }
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :order_id, :food_item_id, :quantity
  #
  # or
  #
  # permit_params do
  #   permitted = [:order_id, :food_item_id, :quantity]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
