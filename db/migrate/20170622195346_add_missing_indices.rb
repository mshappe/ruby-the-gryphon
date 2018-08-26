# frozen_string_literal: true

class AddMissingIndices < ActiveRecord::Migration
  def change
    add_index :award_badges, :award_id
    add_index :award_recipient_images, :award_recipient_id
    add_index :award_recipient_thumbnails, :award_recipient_id
    add_index :award_recommendations, :planned_court_id
    add_index :award_recommendations, :submitted_by_user_id
    add_index :branch_heraldries, :branch_id
    add_index :branches, :parent_branch_id
    add_index :courts, :regent_persona_id
    add_index :courts, :reporter_persona_id
    add_index :courts, :herald_persona_id
    add_index :heraldic_images, :person_id
    add_index :map_images, :branch_id
    add_index :persona_images, :persona_id
    add_index :reign_images, :reign_id
    add_index :reign_maps, :reign_id
    add_index :reigns, :combatant_persona_id
    add_index :reigns, :consort_persona_id
    add_index :reigns, :crown_event_id
    add_index :reigns, :coronation_event_id
    add_index :reigns, :runner_up_persona_id
    add_index :reigns, :runner_up_consort_persona_id
    add_index :warrant_badges, :warrant_type_id
    add_index :warrant_types, :superior_warrant_id
    drop_table :heradry_images
  end
end
