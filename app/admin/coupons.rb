ActiveAdmin.register Coupon do
  menu priority: 6

  permit_params :code, :used_by, :is_active, :amount

  actions :all, except: [:show]

  filter :is_active
  filter :amount
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :code, :is_active, :used_by
  #
  # or
  #
  # permit_params do
  #   permitted = [:code, :is_active, :used_by]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form do |f|
    f.inputs "Coupons" do
      f.input :code
      f.input :amount
      f.input :is_active, as: :boolean, label: "Active"
    end
    f.actions
  end
  
end
