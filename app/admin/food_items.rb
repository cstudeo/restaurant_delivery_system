ActiveAdmin.register FoodItem do
  menu parent: 'RESTAURANTS', label: 'FOOD ITEMS'

  permit_params :name, :price, :description, :restaurant_id, :picture
  filter :name
  filter :restaurant
  filter :price

  form html: { multipart: true } do |f|
    f.inputs "Food Item" do
      f.input :name
      f.input :price
      f.input :description
      f.input :restaurant
      f.file_field :picture, form_html: { multiple: true }
    end

    f.actions
  end

  show do
    attributes_table do
      row :name
      row :price
      row :restaurant
      row :image do |ad|
        image_tag ad.picture.url, size: "200x200"
      end
    end
    active_admin_comments
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :price, :restaurant_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :price, :restaurant_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
