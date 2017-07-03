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
#  deleted_at                 :datetime
#
# Indexes
#
#  index_warrant_types_on_deleted_at           (deleted_at)
#  index_warrant_types_on_superior_warrant_id  (superior_warrant_id)
#

require 'rails_helper'

RSpec.describe WarrantType, :type => :model do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_uniqueness_of :name }
  it { is_expected.to belong_to :superior_warrant }
  it { is_expected.to have_many :posts }
  it { is_expected.to have_many :warrants }
end
