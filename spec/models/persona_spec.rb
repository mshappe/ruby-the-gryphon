# == Schema Information
#
# Table name: personas
#
#  id                         :integer          not null, primary key
#  user_id                    :integer
#  name                       :string
#  honorific                  :string
#  persona_type_id            :integer
#  description                :text
#  name_registered            :datetime
#  persona_image_file_name    :string
#  persona_image_content_type :string
#  persona_image_file_size    :integer
#  persona_image_updated_at   :datetime
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  deleted_at                 :datetime
#
# Indexes
#
#  index_personas_on_deleted_at       (deleted_at)
#  index_personas_on_persona_type_id  (persona_type_id)
#  index_personas_on_user_id          (user_id)
#

require 'rails_helper'

RSpec.describe Persona, :type => :model do
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :persona_type }
  it { is_expected.to have_one(:person).through :user }
  it { is_expected.to have_many :submitted_events }
  it { is_expected.to have_many :stewarded_events }
  it { is_expected.to have_many :event_attendees }
  it { is_expected.to have_many(:events).through :event_attendees }
  it { is_expected.to have_many(:received_awards) }
  it { is_expected.to have_attached_file :persona_image }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_uniqueness_of :name }
  it { is_expected.to validate_presence_of :persona_type }
end
