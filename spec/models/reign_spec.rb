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
#  runenr_up_consort_persona_id :integer
#  reign_map_file_name          :string
#  reign_map_content_type       :string
#  reign_map_file_size          :integer
#  reign_map_updated_at         :datetime
#  reign_map_description        :integer
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#

require 'rails_helper'

RSpec.describe Reign, :type => :model do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_uniqueness_of :name }
  it { is_expected.to belong_to :combatant_persona }
  it { is_expected.to belong_to :consort_persona }
  it { is_expected.to belong_to :runner_up_persona }
  it { is_expected.to belong_to :runner_up_consort_persona }
  it { is_expected.to belong_to :crown_event }
  it { is_expected.to belong_to :coronation_event }
end
