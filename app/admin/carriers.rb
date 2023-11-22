ActiveAdmin.register Carrier do
  menu priority: 5

  permit_params :name, :phone_number, :is_available, :is_verified

  # actions :all, except: [:new, :destroy]

  index do
    selectable_column
    id_column
    column :email
    column :first_name
    column :last_name
    column :created_at
    column :phone_number
    column :is_available
    column :daily_orders_count
    column :account_number
    column :is_verified
    actions
  end

  filter :first_name
  filter :last_name
  filter :phone_number
  filter :email
  filter :daily_orders_count


  show do
    attributes_table do
      row :email
      row :first_name
      row :last_name
      row :phone_number
      row :is_available
      row :created_at
      row :is_verified
      row :account_number do |user|
        user.verification_detail&.account_number
      end

      row :personal_picture do |user|
        image_tag user.verification_detail&.personal_picture&.url, size: "200x200"
      end
      row :student_card do |user|
        image_tag user.verification_detail&.card_picture&.url, size: "200x200"
      end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs "Carrier" do
        f.input :email
        f.input :is_available
        f.input :is_verified
    end
    f.button :Submit
  end

  # edit do
  #   attributes_table do
  #     row :email
  #     row :is_available
  #     row :is_verified

  #     row :personal_picture do |user|
  #       image_tag user.verification_detail.personal_picture.url, size: "200x200"
  #     end
  #     row :student_card do |user|
  #       image_tag user.verification_detail.card_picture.url, size: "200x200"
  #     end
  #   end
  #   active_admin_comments
  # end

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
