# == Schema Information
#
# Table name: authorization_types
#
#  id         :integer          not null, primary key
#  name       :string
#  group      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class AuthorizationType < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :group, presence: true
end
