# frozen_string_literal: true

# == Schema Information
#
# Table name: warrants
#
#  id              :integer          not null, primary key
#  person_id       :integer
#  warrant_type_id :integer
#  tenure_start    :datetime
#  tenure_end      :datetime
#  branch_id       :integer
#  approved        :datetime
#  introduction    :text
#  comments        :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  deleted_at      :datetime
#
# Indexes
#
#  index_warrants_on_branch_id        (branch_id)
#  index_warrants_on_deleted_at       (deleted_at)
#  index_warrants_on_person_id        (person_id)
#  index_warrants_on_warrant_type_id  (warrant_type_id)
#

class Warrant < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :person
  belongs_to :warrant_type
  belongs_to :branch
  has_one :user, through: :person
  validates :tenure_start, presence: true

  scope :approved, -> { where.not(approved: nil) }
  scope :current_holders_by_type, -> (type) { type.warrants.current }

  delegate :name, to: :warrant_type, prefix: true
  delegate :name, to: :person, prefix: true
  delegate :name, to: :branch, prefix: true
end
