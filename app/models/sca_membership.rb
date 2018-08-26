# frozen_string_literal: true

# == Schema Information
#
# Table name: sca_memberships
#
#  sca_number   :string           primary key
#  sca_exp_date :datetime
#
# Indexes
#
#  index_sca_memberships_on_sca_number  (sca_number)
#

class ScaMembership < ActiveRecord::Base
  self.primary_key = :sca_number
end
