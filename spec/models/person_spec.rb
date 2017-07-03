# == Schema Information
#
# Table name: people
#
#  id                          :integer          not null, primary key
#  user_id                     :integer
#  name                        :string
#  phone                       :string
#  phone_message               :string
#  gender                      :string
#  url                         :string
#  date_of_birth               :datetime
#  sca_number                  :string
#  sca_expiration_date         :datetime
#  private_name                :boolean
#  private_address             :boolean
#  private_phone               :boolean
#  private_email               :boolean
#  private_persona             :boolean
#  authorization_expiration    :datetime
#  active                      :boolean
#  device_registered           :datetime
#  deceased                    :datetime
#  heraldic_image_file_name    :string
#  heraldic_image_content_type :string
#  heraldic_image_file_size    :integer
#  heraldic_image_updated_at   :datetime
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  address_id                  :integer
#  branch_id                   :integer
#  deleted_at                  :datetime
#
# Indexes
#
#  index_people_on_address_id  (address_id)
#  index_people_on_branch_id   (branch_id)
#  index_people_on_deleted_at  (deleted_at)
#  index_people_on_user_id     (user_id)
#

require 'rails_helper'

RSpec.describe Person, :type => :model do
  it { is_expected.to have_attached_file :heraldic_image }

  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :address }
  it { is_expected.to belong_to :branch }
  it { is_expected.to have_many :authorizations }
  it { is_expected.to have_many(:personas).through(:user) }
  it { is_expected.to have_many :warrants }
  it { is_expected.to accept_nested_attributes_for :address }

  it { is_expected.to validate_presence_of :name }
end
