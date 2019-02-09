# frozen_string_literal: true

module Submittable
  extend ActiveSupport::Concern

  STATES = %w[queued approved rejected retired].freeze

  included do
    belongs_to :supersedes, class_name: name
    belongs_to :superseded_by, class_name: name

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

  def update_attributes(params)
    if submission_state == 'queued' && params['submission_state'] == 'approved' &&
       supersedes.try(:submission_state) == 'approved'
      supersedes.retire(self)
    end

    super(params)
  end

  def method_missing(method, *args, &block)
    method =~ /^(.*)\?$/
    if STATES.include?($1)
      submission_state == $1
    end
  end
  
end
