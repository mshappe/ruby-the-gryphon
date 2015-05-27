require "rails_helper"

RSpec.describe EventNotification, :type => :mailer do
  let(:user) { create :user, personas: [create(:persona)] }
  let(:event) { create :event, submitter_persona: user.personas.first, submission_state: 'queued' }

  describe 'submitter notification' do
    let(:mail) { EventNotification.notify_submitter(user, event) }

    it 'renders useful information' do
      expect(mail.subject).to eq 'Your submission has been received'
      expect(mail.to).to match_array [user.email]
    end
  end

  describe 'update notification' do
    let(:mail) { EventNotification.notify_submitter_update(->() { event.update_attribute(:submission_state, 'approved'); event }.call) }

    it 'renders useful information' do
      expect(mail.subject).to eq 'Your submission has been approved'
      expect(mail.to).to match_array [user.email]
    end
  end
end
