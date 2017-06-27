# == Schema Information
#
# Table name: warrant_types
#
#  id                         :integer          not null, primary key
#  name                       :string
#  email                      :string
#  warrant_badge_file_name    :string
#  warrant_badge_content_type :string
#  warrant_badge_file_size    :integer
#  warrant_badge_updated_at   :datetime
#  missive                    :boolean
#  stallari_order             :integer
#  job_description            :text
#  superior_warrant_id        :integer
#  background_check_required  :boolean
#  northwatch_display         :boolean
#  icon_file_name             :string
#  active                     :boolean
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
# Indexes
#
#  index_warrant_types_on_superior_warrant_id  (superior_warrant_id)
#

FactoryGirl.define do
  factory :warrant_type do
    name "MyString"
    email "MyString"
    missive false
    stallari_order 1
    job_description "MyText"
    superior_warrant_id 1
    background_check_required false
    northwatch_display false
    icon_file_name "MyString"
    active false
  end

end
