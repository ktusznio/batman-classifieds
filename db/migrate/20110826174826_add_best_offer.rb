class AddBestOffer < ActiveRecord::Migration
  def self.up
    add_column :ads, :best_offer, :boolean
  end

  def self.down
    remove_column :ads, :best_offer, :boolean
  end
end
