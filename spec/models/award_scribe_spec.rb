# frozen_string_literal: true

# == Schema Information
#
# Table name: award_scribes
#
#  id                   :integer          not null, primary key
#  award_recipient_id   :integer
#  person_id            :integer
#  award_scribe_type_id :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_award_scribes_on_award_recipient_id    (award_recipient_id)
#  index_award_scribes_on_award_scribe_type_id  (award_scribe_type_id)
#  index_award_scribes_on_person_id             (person_id)
#

require 'rails_helper'

RSpec.describe AwardScribe, type: :model do
  it { is_expected.to belong_to :award_recipient }
  it { is_expected.to belong_to :person }
  it { is_expected.to belong_to :award_scribe_type }
end
