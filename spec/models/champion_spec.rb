# == Schema Information
#
# Table name: champions
#
#  id         :integer          not null, primary key
#  persona_id :integer
#  reign_id   :integer
#  name       :string(100)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_champions_on_persona_id  (persona_id)
#  index_champions_on_reign_id    (reign_id)
#

require 'rails_helper'

RSpec.describe Champion, type: :model do
  it { is_expected.to belong_to :persona }
  it { is_expected.to belong_to :reign }
  it { is_expected.to validate_presence_of :name }
end
