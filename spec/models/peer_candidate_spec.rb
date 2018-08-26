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

require 'rails_helper'

RSpec.describe PeerCandidate, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
