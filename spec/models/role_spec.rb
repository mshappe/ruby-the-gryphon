# == Schema Information
#
# Table name: roles
#
#  id            :integer          not null, primary key
#  name          :string
#  resource_id   :integer
#  resource_type :string
#  created_at    :datetime
#  updated_at    :datetime
#
# Indexes
#
#  index_roles_on_name                                    (name)
#  index_roles_on_name_and_resource_type_and_resource_id  (name,resource_type,resource_id)
#

require 'rails_helper'

RSpec.describe Role, type: :model do
  it { is_expected.to have_and_belong_to_many :users }
  it { is_expected.to belong_to :resource }
  it { is_expected.to validate_inclusion_of(:resource_type).in_array(Rolify.resource_types) }
end
