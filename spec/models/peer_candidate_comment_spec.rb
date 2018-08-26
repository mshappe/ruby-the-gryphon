# frozen_string_literal: true

# == Schema Information
#
# Table name: peer_candidate_comments
#
#  id                :integer          not null, primary key
#  peer_candidate_id :integer
#  person_id         :integer
#  timestamp         :datetime         not null
#  comments          :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_peer_candidate_comments_on_peer_candidate_id  (peer_candidate_id)
#  index_peer_candidate_comments_on_person_id          (person_id)
#

require 'rails_helper'

RSpec.describe PeerCandidateComment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
