# frozen_string_literal: true

# == Schema Information
#
# Table name: peer_candidates
#
#  id         :integer          not null, primary key
#  award_id   :integer
#  persona_id :integer
#  active     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_peer_candidates_on_active      (active)
#  index_peer_candidates_on_award_id    (award_id)
#  index_peer_candidates_on_persona_id  (persona_id)
#

FactoryBot.define do
  factory :peer_candidate do
    award { nil }
    persona { nil }
  end
end
