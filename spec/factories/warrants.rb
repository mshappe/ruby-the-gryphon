# frozen_string_literal: true
# == Schema Information
#
# Table name: warrants
#
#  id               :integer          not null, primary key
#  person_id        :integer
#  warrant_type_id  :integer
#  tenure_start     :datetime
#  tenure_end       :datetime
#  branch_id        :integer
#  approved_date    :datetime
#  introduction     :text
#  comments         :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  deleted_at       :datetime
#  submission_state :string
#  supersedes_id    :integer
#  superseded_by_id :integer
#
# Indexes
#
#  index_warrants_on_branch_id        (branch_id)
#  index_warrants_on_deleted_at       (deleted_at)
#  index_warrants_on_person_id        (person_id)
#  index_warrants_on_warrant_type_id  (warrant_type_id)
#

FactoryBot.define do
  factory :warrant do
    association :person
    association :warrant_type
    association :branch
    tenure_start { '2016-02-19 14:52:57' }
    tenure_end { nil }
    approved_date { '2016-02-19 14:52:57' }
    introduction { 'MyText' }
    comments { 'MyText' }
    submission_state { 'approved' }
  end
end
