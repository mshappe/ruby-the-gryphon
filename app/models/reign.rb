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

class Reign < ActiveRecord::Base
  has_paper_trail

  belongs_to :combatant_persona, class_name: 'Persona', foreign_key: 'combatant_persona_id'
  belongs_to :consort_persona, class_name: 'Persona', foreign_key: 'consort_persona_id'
  belongs_to :runner_up_persona, class_name: 'Persona', foreign_key: 'runner_up_persona_id'
  belongs_to :runner_up_consort_persona, class_name: 'Persona', foreign_key: 'runner_up_consort_persona_id'
  belongs_to :crown_event, class_name: 'Event', foreign_key: 'crown_event_id'
  belongs_to :coronation_event, class_name: 'Event', foreign_key: 'coronation_event_id'

  has_attached_file :reign_image, storage: :database
  has_attached_file :reign_map, storage: :database

  validates :name, presence: true, uniqueness: true
  validates_attachment_content_type :reign_image, :content_type => /\Aimage\/.*\Z/
  validates_attachment_content_type :reign_map, :content_type => /\Aimage\/.*\Z/
end
