ActiveAdmin.register Customer do
  menu priority: 4

  actions :all, except: [:edit, :show, :new]

  index do
    selectable_column
    id_column
    column :email
    column :first_name
    column :last_name
    column :created_at
    column :phone_number
    actions
  end

  filter :first_name
  filter :last_name
  filter :phone_number
  filter :email

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :first_name, :last_name, :phone_number, :is_available, :daily_orders_count, :type, :reset_password_token, :reset_password_sent_at, :remember_created_at
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :first_name, :last_name, :phone_number, :is_available, :daily_orders_count, :type, :reset_password_token, :reset_password_sent_at, :remember_created_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
