# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Total Orders" do
          "#{content_tag(:strong, Order.count)}".html_safe
        end
      end

      column do
        panel "Total Customers" do
          "#{content_tag(:strong, Customer.count)}".html_safe
        end
      end

      column do
        panel "Total Carriers" do
          "#{content_tag(:strong, Carrier.count)}".html_safe
        end
      end
    end
  end
end
