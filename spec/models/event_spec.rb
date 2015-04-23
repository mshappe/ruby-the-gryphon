# == Schema Information
#
# Table name: events
#
#  id                   :integer          not null, primary key
#  name                 :string
#  start_at             :datetime
#  end_at               :datetime
#  url                  :string
#  approved             :boolean
#  branch_id            :integer
#  sponsor_branch_id    :integer
#  unlisted_host        :string
#  unlisted_sponsor     :string
#  site_name            :string
#  address_id           :integer
#  web_ad               :text
#  comments             :text
#  admin_comments       :text
#  submitter_persona_id :integer
#  submitter_sca_name   :string
#  submitter_legal_name :string
#  submitter_phone      :string
#  submitter_email      :string
#  steward_persona_id   :integer
#  steward_sca_name     :string
#  steward_legal_name   :string
#  steward_phone        :string
#  steward_email        :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_events_on_address_id            (address_id)
#  index_events_on_branch_id             (branch_id)
#  index_events_on_sponsor_branch_id     (sponsor_branch_id)
#  index_events_on_steward_persona_id    (steward_persona_id)
#  index_events_on_submitter_persona_id  (submitter_persona_id)
#

require 'rails_helper'

RSpec.describe Event, :type => :model do
  it { is_expected.to belong_to :branch }
  it { is_expected.to belong_to :sponsor_branch }
  it { is_expected.to belong_to :address }
  it { is_expected.to belong_to :submitter_persona }
  it { is_expected.to belong_to :steward_persona }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :start_at }
  it { is_expected.to validate_presence_of :end_at }
end
