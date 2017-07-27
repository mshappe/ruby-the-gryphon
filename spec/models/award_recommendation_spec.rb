# == Schema Information
#
# Table name: award_recommendations
#
#  id                     :integer          not null, primary key
#  award_id               :integer
#  persona_id             :integer
#  persona_name           :string
#  legal_name             :string
#  branch_id              :integer
#  gender                 :string
#  persona_description    :text
#  is_youth               :boolean
#  sca_term               :integer
#  reason                 :text
#  status                 :string
#  planned_court_id       :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  submitted_by_person_id :integer
#
# Indexes
#
#  index_award_recommendations_on_award_id          (award_id)
#  index_award_recommendations_on_branch_id         (branch_id)
#  index_award_recommendations_on_persona_id        (persona_id)
#  index_award_recommendations_on_planned_court_id  (planned_court_id)
#

require 'rails_helper'

RSpec.describe AwardRecommendation, :type => :model do
  it { is_expected.to belong_to :award }
  it { is_expected.to belong_to :persona }
  it { is_expected.to belong_to :branch }
  it { is_expected.to belong_to :planned_court }
  it { is_expected.to belong_to :submitted_by_person }
  it { is_expected.to validate_inclusion_of(:status).in_array [AwardRecommendation::STATUS_HIDE, AwardRecommendation::STATUS_SHOW]}
  it { is_expected.to validate_presence_of :award }
  it { is_expected.to validate_presence_of :reason }

  describe 'with neither a persona_id or persona_name' do
    before :each do
      subject.status = AwardRecommendation::STATUS_SHOW
      subject.persona_id = nil
      subject.persona_name = nil
    end

    it 'sets errors' do
      expect(subject).to_not be_valid
      expect(subject.errors[:persona].first).to match %r[either]
    end
  end

  describe 'with both a persona_id and a persona_name' do
    before :each do
      subject.status = AwardRecommendation::STATUS_SHOW
      subject.persona = create :persona
      subject.persona_name = 'Moose'
    end

    it 'sets errors' do
      expect(subject).to_not be_valid
      expect(subject.errors[:persona].first).to match %[not both]
    end
  end

  describe 'without a persona_id, legal_name and branch_id should be set' do
    before :each do
      subject.status = AwardRecommendation::STATUS_SHOW
      subject.persona_id = nil
    end

    it { is_expected.to validate_presence_of :branch }
    it { is_expected.to validate_presence_of :legal_name }
  end

  describe 'with a persona_id, legal_name and branch_id should not be set' do
    before :each do
      subject.status = AwardRecommendation::STATUS_SHOW
      subject.persona = create :persona
    end

    it { is_expected.to_not validate_presence_of :branch }
    it { is_expected.to_not validate_presence_of :legal_name }
  end
end
