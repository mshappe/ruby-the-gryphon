class CreatePeerCandidateComments < ActiveRecord::Migration
  def change
    create_table :peer_candidate_comments do |t|
      t.references :peer_candidate, index: true, foreign_key: true
      t.references :person, index: true, foreign_key: true
      t.timestamp :timestamp, null: false
      t.text :comments

      t.timestamps null: false
    end
  end
end
