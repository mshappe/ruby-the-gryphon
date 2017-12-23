# == Schema Information
#
# Table name: personas
#
#  id                         :integer          not null, primary key
#  user_id                    :integer
#  name                       :string
#  honorific                  :string
#  persona_type_id            :integer
#  description                :text
#  name_registered            :datetime
#  persona_image_file_name    :string
#  persona_image_content_type :string
#  persona_image_file_size    :integer
#  persona_image_updated_at   :datetime
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  deleted_at                 :datetime
#
# Indexes
#
#  index_personas_on_deleted_at       (deleted_at)
#  index_personas_on_persona_type_id  (persona_type_id)
#  index_personas_on_user_id          (user_id)
#

FactoryBot.define do
  factory :persona do
    user
    sequence(:name) { Faker::Name.name }
    honorific "MyString"
    persona_type
    description "MyText"
    name_registered "2015-04-13 20:25:33"
  end

end
