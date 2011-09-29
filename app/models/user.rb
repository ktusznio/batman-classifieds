class User < ActiveRecord::Base
  has_many :ads

  def name
    first_name + " " + last_name
  end

  def display_name
    "#{first_name} #{last_name.first}"
  end
end
