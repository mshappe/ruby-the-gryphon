module Submittable
  extend ActiveSupport::Concern

  STATES = %w[queued approved rejected retired]

  included do
    belongs_to :supersedes, class_name: self.name
    belongs_to :superseded_by, class_name: self.name

    validates :submission_state, presence: true, inclusion: STATES

    scope :approved, -> { where submission_state: 'approved' }
    scope :queued, -> { where submission_state: 'queued' }
    scope :rejected, -> { where submission_state: 'rejected' }
    scope :retired, -> { where submission_state: 'retired' }
  end

  def retire(successor)
    self.submission_state = 'retired'
    successor.submission_state = 'approved'
    self.superseded_by = successor
    successor.supersedes = self
  end
end