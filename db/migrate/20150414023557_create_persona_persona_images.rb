class CreatePersonaPersonaImages < ActiveRecord::Migration
  def self.up
    create_table :persona_images do |t|
      t.integer    :persona_id
      t.string     :style
      t.binary     :file_contents
    end
  end

  def self.down
    drop_table :persona_images
  end
end
