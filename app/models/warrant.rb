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
#
# Indexes
#
#  index_warrants_on_branch_id        (branch_id)
#  index_warrants_on_person_id        (person_id)
#  index_warrants_on_warrant_type_id  (warrant_type_id)
#

class Warrant < ActiveRecord::Base
  belongs_to :person
  belongs_to :warrant_type
  belongs_to :branch
  validates :tenure_start, presence: true

  scope :approved, -> { where.not(approved: nil) }
  scope :current_holders_by_type, -> (type) do
    now = DateTime.current
    where(warrant_type: type)
      .approved
      .where('tenure_start < ?', now)
      .where('tenure_end IS NULL')
      .order(:tenure_start)
  end
end
