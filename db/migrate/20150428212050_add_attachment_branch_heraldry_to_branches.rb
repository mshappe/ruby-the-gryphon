class AddAttachmentBranchHeraldryToBranches < ActiveRecord::Migration
  def self.up
    remove_column :branches, :branch_heraldry if column_exists? :branches, :branch_heraldry
    remove_column :branches, :map_image if column_exists? :branches, :map_image
    change_table :branches do |t|
      t.attachment :branch_heraldry
      t.attachment :map_image
    end
  end

  def self.down
    remove_attachment :branches, :map_image
    remove_attachment :branches, :branch_heraldry
    add_column :branches, :map_image, :string
    add_column :branches, :branch_heraldry, :string
  end
end
