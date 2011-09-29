class UpdateExistingAdStatus < ActiveRecord::Migration
  def self.up
    Ad.update_all("state = 'active'", "state IS NULL")
  end

  def self.down
  end
end
