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
#  sca_number                  :integer
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
#
# Indexes
#
#  index_people_on_user_id  (user_id)
#

FactoryGirl.define do
  factory :person do
    user
    name "MyString"
    phone "MyString"
    phone_message "MyString"
    gender "MyString"
    url "MyString"
    date_of_birth "2015-04-13 17:27:22"
    sca_number 1
    sca_expiration_date "2015-04-13 17:27:22"
    private_name false
    private_address false
    private_phone false
    private_email false
    private_persona false
    authorization_expiration "2015-04-13 17:27:22"
    active false
    device_registered "2015-04-13 17:27:22"
    deceased false
  end

end
