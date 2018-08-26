# frozen_string_literal: true

# == Schema Information
#
# Table name: branch_types
#
#  id          :integer          not null, primary key
#  name        :string
#  full_status :boolean
#  has_award   :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class BranchType < ActiveRecord::Base
  has_paper_trail

  validates :name, presence: true, uniqueness: true
end
