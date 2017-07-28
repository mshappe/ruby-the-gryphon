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

class Champion < ActiveRecord::Base
  belongs_to :persona
  belongs_to :reign

  validates :name, presence: true
end
