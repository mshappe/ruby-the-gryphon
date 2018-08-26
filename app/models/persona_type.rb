# frozen_string_literal: true

# == Schema Information
#
# Table name: persona_types
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_persona_types_on_name  (name)
#

class PersonaType < ActiveRecord::Base
  has_many :personas

  validates :name, presence: true, uniqueness: true
end
