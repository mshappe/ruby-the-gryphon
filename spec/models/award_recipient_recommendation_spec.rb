# == Schema Information
#
# Table name: award_recipient_recommendations
#
#  id                      :integer          not null, primary key
#  award_recipient_id      :integer
#  award_recommendation_id :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
# Indexes
#
#  award_rec_on_award_rec_id                                    (award_recommendation_id)
#  index_award_recipient_recommendations_on_award_recipient_id  (award_recipient_id)
#

require 'rails_helper'

RSpec.describe AwardRecipientRecommendation, :type => :model do
  it { is_expected.to belong_to :award_recipient }
  it { is_expected.to belong_to :award_recommendation }
end
