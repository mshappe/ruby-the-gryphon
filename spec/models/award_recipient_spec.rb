# == Schema Information
#
# Table name: award_recipients
#
#  id                                     :integer          not null, primary key
#  award_id                               :integer
#  persona_id                             :integer
#  court_id                               :integer
#  status_id                              :integer
#  received                               :datetime
#  revoked                                :datetime
#  award_recipient_thumbnail_file_name    :string
#  award_recipient_thumbnail_content_type :string
#  award_recipient_thumbnail_file_size    :integer
#  award_recipient_thumbnail_updated_at   :datetime
#  award_recipient_image_file_name        :string
#  award_recipient_image_content_type     :string
#  award_recipient_image_file_size        :integer
#  award_recipient_image_updated_at       :datetime
#  award_content                          :text
#  creation_notes                         :text
#  reason                                 :text
#  note                                   :text
#  created_at                             :datetime         not null
#  updated_at                             :datetime         not null
#
# Indexes
#
#  index_award_recipients_on_award_id    (award_id)
#  index_award_recipients_on_court_id    (court_id)
#  index_award_recipients_on_persona_id  (persona_id)
#

require 'rails_helper'

RSpec.describe AwardRecipient, :type => :model do
  it { is_expected.to belong_to :award }
  it { is_expected.to belong_to :persona }
  it { is_expected.to belong_to :court }

  context '#by_award' do
    before :each do
      @award = create :award
      @we_want = create :award_recipient, award: @award, received: DateTime.now
      @we_dont_want = create :award_recipient
    end

    it 'should return recipients by award' do
      expect(AwardRecipient.by_award(@award)).to match_array [@we_want]
    end

    context 'multiple recipients' do
      before :each do
        @we_also_want = create :award_recipient, award: @award, received: 7.days.ago
      end

      it 'should return in order of receipt' do
        # Order matters, so eq not match_array
        expect(AwardRecipient.by_award(@award)).to eq [@we_also_want, @we_want]
      end
    end
  end
end
