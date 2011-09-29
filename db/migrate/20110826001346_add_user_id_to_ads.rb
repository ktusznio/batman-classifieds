class AddUserIdToAds < ActiveRecord::Migration
  def self.up
    add_column :ads, :user_id, :integer
  end

  def self.down
    remove_column :ads, :user_id
  end
end
