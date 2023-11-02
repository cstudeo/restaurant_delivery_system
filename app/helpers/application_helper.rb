module ApplicationHelper
  def full_name
    user = current_user
    "#{user.first_name} #{user.last_name}"
  end
end
