class CreateAdStateTransitions < ActiveRecord::Migration
  def self.up
    add_column :ads, :state, :string
    
    create_table :ad_state_transitions do |t|
      t.references :ad
      t.string :event
      t.string :from
      t.string :to
      t.timestamp :created_at
    end
  end

  def self.down
    remove_column :ads, :state
    drop_table :ad_state_transitions
  end
end
