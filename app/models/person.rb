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
#
# Indexes
#
#  index_people_on_address_id  (address_id)
#  index_people_on_branch_id   (branch_id)
#  index_people_on_user_id     (user_id)
#

class Person < ActiveRecord::Base
  has_paper_trail
  has_attached_file :heraldic_image, storage: :database, cascade_deletion: true
  validates_attachment_content_type :heraldic_image, :content_type => /\Aimage\/.*\Z/

  belongs_to :user
  belongs_to :address
  belongs_to :branch
  has_many :authorizations
  has_many :warrants

  accepts_nested_attributes_for :address

  phony_normalize :phone, default_country_code: 'US'

  validates :name, presence: true
  validates :phone, phony_plausible: true

  delegate :email, to: :user
end
