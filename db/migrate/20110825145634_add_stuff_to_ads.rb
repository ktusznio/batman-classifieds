class AddStuffToAds < ActiveRecord::Migration
  def self.up
    change_table :ads do |t|
      t.column :title, :string
      t.column :sale_type, :string
      t.column :price, :decimal, :precision => 10, :scale => 2
      t.column :description, :text
    end
  end

  def self.down
    change_table :ads do |t|
      t.remove :title
      t.remove :price
      t.remove :description
      t.remove :sale_type
    end
  end
end
