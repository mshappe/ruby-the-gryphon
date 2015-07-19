class CreateReigns < ActiveRecord::Migration
  def change
    create_table :reigns do |t|
      t.string :name
      t.integer :combatant_persona_id
      t.integer :consort_persona_id
      t.attachment :reign_image
      t.integer :crown_event_id
      t.integer :coronation_event_id
      t.string :url
      t.integer :runner_up_persona_id
      t.integer :runenr_up_consort_persona_id
      t.attachment :reign_map
      t.integer :reign_map_description

      t.timestamps null: false
    end
  end
end
