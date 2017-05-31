class CreatePeerCandidates < ActiveRecord::Migration
  def change
    create_table :peer_candidates do |t|
      t.references :award, index: true, foreign_key: true
      t.references :persona, index: true, foreign_key: true
      t.boolean :active, index: true

      t.timestamps null: false
    end
  end
end
