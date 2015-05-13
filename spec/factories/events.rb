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
#  submission_state     :string
#  supersedes_id        :integer
#  superseded_by_id     :integer
#
# Indexes
#
#  index_events_on_address_id            (address_id)
#  index_events_on_branch_id             (branch_id)
#  index_events_on_sponsor_branch_id     (sponsor_branch_id)
#  index_events_on_steward_persona_id    (steward_persona_id)
#  index_events_on_submission_state      (submission_state)
#  index_events_on_submitter_persona_id  (submitter_persona_id)
#

FactoryGirl.define do
  factory :event do
    name "MyString"
    start_at "2015-04-21 17:05:19"
    end_at "2015-04-21 17:05:19"
    url "MyString"
    branch nil
    sponsor_branch nil
    unlisted_host "MyString"
    unlisted_sponsor "MyString"
    site_name "MyString"
    address nil
    web_ad "MyText"
    comments "MyText"
    admin_comments "MyText"
    submitter_persona nil
    submitter_sca_name "MyString"
    submitter_legal_name "MyString"
    submitter_phone "MyString"
    submitter_email "MyString"
    steward_persona nil
    steward_sca_name "MyString"
    steward_legal_name "MyString"
    steward_phone "MyString"
    steward_email "MyString"
    submission_state 'queued'
  end

end
