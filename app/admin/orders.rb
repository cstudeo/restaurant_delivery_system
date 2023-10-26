ActiveAdmin.register Order do
  menu priority: 5

  permit_params :status, :is_available

  actions :all, except: [:show, :new]

  index do
    selectable_column
    id_column
    column :carrier
    column :customer
    column :total_amount
    column :created_at
    column :picked_up_at
    actions
  end

  filter :restaurant
  filter :created_at
  filter :user
  filter :total_amount
  filter :customer, as: :select, collection: Customer.all.map { |user| [user.email, user.id] }
  filter :carrier, as: :select, collection: Carrier.all.map { |user| [user.email, user.id] }
              

  form do |f|
    f.inputs "Orders" do
      f.input :status, as: :select, collection: [["Not Completed", 0], ["Completed", 1]]
    end
    f.actions
  end

  show do
    attributes_table do
      # row :id
      # row :customer
      # row :status
      # # Add any other order-related attributes you want to display

      # Display associated order items
      row 'Order Items' do
        table_for order.order_items do
          column :product
          column :quantity
          column :price
          # Add any other order item attributes you want to display
        end
      end
    end
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :restaurant_id, :total_amount, :customer_id, :carrier_id, :status, :picked_up_at
  #
  # or
  #
  # permit_params do
  #   permitted = [:restaurant_id, :total_amount, :customer_id, :carrier_id, :status, :picked_up_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
