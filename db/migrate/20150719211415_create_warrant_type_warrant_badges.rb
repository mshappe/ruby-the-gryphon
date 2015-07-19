class CreateWarrantTypeWarrantBadges < ActiveRecord::Migration
  def self.up
    create_table :warrant_badges do |t|
      t.integer    :warrant_type_id
      t.string     :style
      t.binary     :file_contents
    end
  end

  def self.down
    drop_table :warrant_badges
  end
end
