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

class PeerCandidateComment < ActiveRecord::Base
  belongs_to :peer_candidate
  belongs_to :person
end
