class CreateAwardScribes < ActiveRecord::Migration
  def change
    create_table :award_scribes do |t|
      t.references :award_recipient, index: true, foreign_key: true
      t.references :person, index: true, foreign_key: true
      t.references :award_scribe_type, index: true

      t.timestamps null: false
    end
  end
end
