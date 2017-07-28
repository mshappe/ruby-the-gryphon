# == Schema Information
#
# Table name: polls
#
#  id         :integer          not null, primary key
#  question   :text
#  active     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Poll < ActiveRecord::Base
  has_many :poll_answers, dependent: :destroy
end
