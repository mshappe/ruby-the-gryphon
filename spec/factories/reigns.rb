# frozen_string_literal: true

# == Schema Information
#
# Table name: reigns
#
#  id                           :integer          not null, primary key
#  name                         :string
#  combatant_persona_id         :integer
#  consort_persona_id           :integer
#  reign_image_file_name        :string
#  reign_image_content_type     :string
#  reign_image_file_size        :integer
#  reign_image_updated_at       :datetime
#  crown_event_id               :integer
#  coronation_event_id          :integer
#  url                          :string
#  runner_up_persona_id         :integer
#  runner_up_consort_persona_id :integer
#  reign_map_file_name          :string
#  reign_map_content_type       :string
#  reign_map_file_size          :integer
#  reign_map_updated_at         :datetime
#  reign_map_description        :integer
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#
# Indexes
#
#  index_reigns_on_combatant_persona_id          (combatant_persona_id)
#  index_reigns_on_consort_persona_id            (consort_persona_id)
#  index_reigns_on_coronation_event_id           (coronation_event_id)
#  index_reigns_on_crown_event_id                (crown_event_id)
#  index_reigns_on_runner_up_consort_persona_id  (runner_up_consort_persona_id)
#  index_reigns_on_runner_up_persona_id          (runner_up_persona_id)
#

FactoryBot.define do
  factory :reign do
    name { 'MyString' }
    combatant_persona_id { 1 }
    consort_persona_id { 1 }
    crown_event_id { 1 }
    coronation_event_id { 1 }
    url { 'MyString' }
    runner_up_persona_id { 1 }
    runner_up_consort_persona_id { 1 }
    reign_map_description { 1 }
  end
end
