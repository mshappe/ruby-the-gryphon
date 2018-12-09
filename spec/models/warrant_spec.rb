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

require 'rails_helper'

RSpec.describe Warrant, type: :model do
  it { is_expected.to belong_to :warrant_type }
  it { is_expected.to belong_to :person }
  it { is_expected.to belong_to :branch }
  it { is_expected.to have_one(:user).through :person }
  it { is_expected.to validate_presence_of :branch }
  it { is_expected.to validate_presence_of :person }
  it { is_expected.to validate_presence_of :warrant_type }
  it { is_expected.to validate_presence_of :tenure_start }

  it_behaves_like 'submittable', :warrant

  describe '.current_holders_by_type' do
    describe 'with a single holder' do
      before :each do
        @warrant_type = create :warrant_type
        @current_warrant = create :warrant, warrant_type: @warrant_type, tenure_start: 1.year.ago, tenure_end: nil, submission_state: 'approved', approved_date: 1.year.ago
        @past_warrant = create :warrant, branch: @current_warrant.branch, warrant_type: @warrant_type, tenure_start: 3.years.ago, tenure_end: 1.year.ago, submission_state: 'approved', approved_date: 3.years.ago
        @unapproved_warrant = create :warrant, branch: @current_warrant.branch, warrant_type: @warrant_type, submission_state: 'queued', approved_date: nil, tenure_start: 3.days.ago, tenure_end: nil
      end

      it 'should return the current holder and not the past holder or unapproved holder' do
        expect(Warrant.current_holders_by_type(@warrant_type)).to match_array [@current_warrant]
      end
    end

    describe 'with multiple holders (e.g. at-large)' do
      before :each do
        @warrant_type = create :warrant_type
        @one = create :warrant, warrant_type: @warrant_type, tenure_start: 1.year.ago, submission_state: 'approved', approved_date: 1.year.ago
        @two = create :warrant, warrant_type: @warrant_type, tenure_start: 2.year.ago, submission_state: 'approved', approved_date: 2.year.ago, branch: @one.branch
        @three = create :warrant, warrant_type: @warrant_type, tenure_start: 6.months.ago, submission_state: 'approved', approved_date: 6.months.ago, branch: @one.branch
        @unapproved_warrant = create :warrant, branch: @one.branch, warrant_type: @warrant_type, submission_state: 'queued', approved_date: nil, tenure_start: 3.days.ago
      end

      it 'should return all current holders ordered by start date' do
        expect(Warrant.current_holders_by_type(@warrant_type)).to eq [@two, @one, @three]
      end
    end
  end
end
