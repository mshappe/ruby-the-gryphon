# == Schema Information
#
# Table name: authorization_types
#
#  id                       :integer          not null, primary key
#  name                     :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  martial_activity_type_id :integer
#
# Indexes
#
#  index_authorization_types_on_martial_activity_type_id  (martial_activity_type_id)
#

class AuthorizationType < ActiveRecord::Base
  belongs_to :martial_activity_type
  validates :name, presence: true, uniqueness: { scope: :martial_activity_type_id }
end
