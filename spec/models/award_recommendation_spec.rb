# == Schema Information
#
# Table name: award_recommendations
#
#  id                   :integer          not null, primary key
#  award_id             :integer
#  persona_id           :integer
#  persona_name         :string
#  legal_name           :string
#  branch_id            :integer
#  gender               :string
#  persona_description  :text
#  is_youth             :boolean
#  sca_term             :integer
#  reason               :text
#  status               :string
#  planned_court_id     :integer
#  submitted_by_user_id :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_award_recommendations_on_award_id    (award_id)
#  index_award_recommendations_on_branch_id   (branch_id)
#  index_award_recommendations_on_persona_id  (persona_id)
#

require 'rails_helper'

RSpec.describe AwardRecommendation, :type => :model do
  it { is_expected.to belong_to :award }
  it { is_expected.to belong_to :persona }
  it { is_expected.to belong_to :branch }
  it { is_expected.to belong_to :planned_court }
  it { is_expected.to belong_to :submitted_by_user }
end
