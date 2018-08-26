# frozen_string_literal: true

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

class AwardRecipientRecommendation < ActiveRecord::Base
  belongs_to :award_recipient
  belongs_to :award_recommendation
end
