class Customer < User
  def self.roles
    %w(admin carrier customer)
  end
end
