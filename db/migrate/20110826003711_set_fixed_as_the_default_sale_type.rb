class SetFixedAsTheDefaultSaleType < ActiveRecord::Migration
  def self.up
    change_column_default :ads, :sale_type, "fixed"
  end

  def self.down
    change_column_default :ads, :sale_type, nil
  end
end
