# frozen_string_literal: true

# == Schema Information
#
# Table name: report_templates
#
#  id              :integer          not null, primary key
#  warrant_type_id :integer
#  title           :string
#  fields          :jsonb
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_report_templates_on_warrant_type_id  (warrant_type_id)
#

require 'rails_helper'

RSpec.describe ReportTemplate, type: :model do
  it { is_expected.to belong_to :warrant_type }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_uniqueness_of :title }

  describe 'field validation' do
    before :each do
      subject.title = Faker::Lorem.sentence
    end
    it 'should have nil or array for report_fields' do
      expect(subject).to be_valid

      subject.report_fields = []
      expect(subject).to be_valid

      subject.report_fields = 'lizard'
      expect(subject).to be_invalid
    end

    it 'should only allow certain keys in each record' do
      subject.report_fields = [
        { type: 'text', title: Faker::Dune.saying },
        { type: 'choice', title: Faker::Dune.saying, choices: [] }
      ]
      expect(subject).to be_valid

      subject.report_fields << { wombat: 'lizard' }
      expect(subject).to be_invalid
    end

    it 'must have a type and a title in each record' do
      subject.report_fields = [
        {}
      ]
      expect(subject).to be_invalid

      subject.report_fields.first[:type] = 'text'
      expect(subject).to be_invalid

      subject.report_fields.first[:title] = Faker::Dune.saying
      expect(subject).to be_valid
    end

    it 'should have a type of "text" or "choice"' do
      subject.report_fields = [
        {
          type: 'lizard', title: Faker::Dune.saying
        }
      ]
      expect(subject).to be_invalid

      subject.report_fields.first[:type] = 'text'
      expect(subject).to be_valid
    end

    it 'should require a choices key with a string array for the choice type' do
      subject.report_fields = [
        { type: 'choice', title: Faker::Dune.saying }
      ]
      expect(subject).to be_invalid

      subject.report_fields.first[:choices] = 'lizard'
      expect(subject).to be_invalid

      subject.report_fields.first[:choices] = []
      expect(subject).to be_valid
    end
  end
end
