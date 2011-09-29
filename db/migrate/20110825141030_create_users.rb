class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :uid
      t.string :email
      t.string :first_name
      t.string :last_name

      t.timestamps
    end

    add_index :users, :email
    add_index :users, :uid
  end

  def self.down
    drop_table :users
  end
end
