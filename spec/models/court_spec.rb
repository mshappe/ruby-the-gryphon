# frozen_string_literal: true

# == Schema Information
#
# Table name: courts
#
#  id                  :integer          not null, primary key
#  court_order         :integer          default(1)
#  court_date          :datetime
#  event_id            :integer
#  reign_id            :integer
#  regent_persona_id   :integer
#  reporter_persona_id :integer
#  herald_persona_id   :integer
#  note                :text
#  planning_notes      :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_courts_on_event_id             (event_id)
#  index_courts_on_herald_persona_id    (herald_persona_id)
#  index_courts_on_regent_persona_id    (regent_persona_id)
#  index_courts_on_reign_id             (reign_id)
#  index_courts_on_reporter_persona_id  (reporter_persona_id)
#

require 'rails_helper'

RSpec.describe Court, type: :model do
  it { is_expected.to belong_to :event }
  it { is_expected.to belong_to :reign }
  it { is_expected.to belong_to :regent_persona }
  it { is_expected.to belong_to :reporter_persona }
  it { is_expected.to belong_to :herald_persona }
end
