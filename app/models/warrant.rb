# frozen_string_literal: true
# == Schema Information
#
# Table name: warrants
#
#  id               :integer          not null, primary key
#  person_id        :integer
#  warrant_type_id  :integer
#  tenure_start     :datetime
#  tenure_end       :datetime
#  branch_id        :integer
#  approved_date    :datetime
#  introduction     :text
#  comments         :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  deleted_at       :datetime
#  submission_state :string
#  supersedes_id    :integer
#  superseded_by_id :integer
#
# Indexes
#
#  index_warrants_on_branch_id        (branch_id)
#  index_warrants_on_deleted_at       (deleted_at)
#  index_warrants_on_person_id        (person_id)
#  index_warrants_on_warrant_type_id  (warrant_type_id)
#

class Warrant < ActiveRecord::Base
  include Submittable

  acts_as_paranoid
  has_paper_trail

  # These are to facilitate dynamic form magic. Eventually, we might use
  # a psuedo-model for the form to clean this up, but for now, perfect is
  # the enemy of good.
  attr_accessor :office_scope

  belongs_to :person
  belongs_to :warrant_type
  belongs_to :branch
  has_one :user, through: :person
  validates :branch, presence: true
  validates :person, presence: true
  validates :warrant_type, presence: true
  validates :tenure_start, presence: true

  scope :current_holders_by_type, -> (type) { type.warrants.current }
  scope :current, -> do
    now = DateTime.current
    approved
    .where('tenure_start < ?', now)
    .where('tenure_end IS NULL')
    .order(:tenure_start)
  end 

  delegate :name, to: :warrant_type, prefix: true
  delegate :name, to: :person, prefix: true
  delegate :name, to: :branch, prefix: true
end
