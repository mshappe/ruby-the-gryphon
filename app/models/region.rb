# == Schema Information
#
# Table name: regions
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Region < ActiveRecord::Base
  has_paper_trail
  resourcify

  validates :name, presence: true, uniqueness: true
end
