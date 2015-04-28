class CreateBranchMapImages < ActiveRecord::Migration
  def self.up
    create_table :map_images do |t|
      t.integer    :branch_id
      t.string     :style
      t.binary     :file_contents
    end
  end

  def self.down
    drop_table :map_images
  end
end
