# frozen_string_literal: true

# == Schema Information
#
# Table name: authorizations
#
#  id                    :integer          not null, primary key
#  person_id             :integer
#  authorization_type_id :integer
#  date_of               :datetime
#  notes                 :text
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Indexes
#
#  index_authorizations_on_authorization_type_id  (authorization_type_id)
#  index_authorizations_on_person_id              (person_id)
#

class Authorization < ActiveRecord::Base
  belongs_to :person
  belongs_to :authorization_type
  validates :date_of, presence: true
end
