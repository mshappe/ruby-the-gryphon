# == Schema Information
#
# Table name: warrants
#
#  id              :integer          not null, primary key
#  person_id       :integer
#  warrant_type_id :integer
#  tenure_start    :datetime
#  tenure_end      :datetime
#  branch_id       :integer
#  approved        :datetime
#  introduction    :text
#  comments        :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  deleted_at      :datetime
#
# Indexes
#
#  index_warrants_on_branch_id        (branch_id)
#  index_warrants_on_deleted_at       (deleted_at)
#  index_warrants_on_person_id        (person_id)
#  index_warrants_on_warrant_type_id  (warrant_type_id)
#

FactoryGirl.define do
  factory :warrant do
    person nil
warrant_type nil
tenure_start "2016-02-19 14:52:57"
tenure_end nil
branch nil
approved "2016-02-19 14:52:57"
introduction "MyText"
comments "MyText"
  end

end
