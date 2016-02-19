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
#
# Indexes
#
#  index_warrants_on_branch_id        (branch_id)
#  index_warrants_on_person_id        (person_id)
#  index_warrants_on_warrant_type_id  (warrant_type_id)
#

require 'rails_helper'

RSpec.describe Warrant, :type => :model do
  it { is_expected.to belong_to :warrant_type }
  it { is_expected.to belong_to :person }
  it { is_expected.to belong_to :branch }
  it { is_expected.to validate_presence_of :tenure_start }
end
