require 'rails_helper'

RSpec.shared_examples 'submittable' do |type|
  it { is_expected.to validate_presence_of :submission_state }
  it { is_expected.to validate_inclusion_of(:submission_state).in_array Submittable::STATES }
  it { is_expected.to belong_to :supersedes }
  it { is_expected.to belong_to :superseded_by }

  describe 'scopes' do
    before :each do
      @approved = create type, submission_state: 'approved'
      @queued = create type, submission_state: 'queued'
      @rejected = create type, submission_state: 'rejected'
      @retired = create type, submission_state: 'retired'
    end

    Submittable::STATES.each do |state|
      describe "#{state}" do
        it "should only have @#{state}" do
          expect(Event.send state).to match_array [self.instance_variable_get("@#{state}")]
        end
      end
    end
  end

  describe 'supersession' do
    before :each do
      @original = create type, submission_state: 'approved'
      @successor = create type, submission_state: 'queued'

      @original.retire(@successor)
    end

    it 'expects supersession to be set up right' do
      expect(@original.submission_state).to eq 'retired'
      expect(@original.superseded_by.id).to eq @successor.id
      expect(@successor.submission_state).to eq 'approved'
      expect(@successor.supersedes.id).to eq @original.id
    end
  end
end
