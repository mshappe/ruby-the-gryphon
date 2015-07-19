class CreateAwardAwardBadges < ActiveRecord::Migration
  def self.up
    create_table :award_badges do |t|
      t.integer    :award_id
      t.string     :style
      t.binary     :file_contents
    end
  end

  def self.down
    drop_table :award_badges
  end
end
