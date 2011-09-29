class AddMissingIndexes < ActiveRecord::Migration
  def self.up
    add_index :ads, [:state, :sale_type]
    add_index :images, :ad_id
  end

  def self.down
    remove_index :images, :ad_id
    remove_index :ads, [:state, :sale_type]
  end
end
