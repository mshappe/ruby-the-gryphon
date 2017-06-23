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

class WarrantType < ActiveRecord::Base
  has_paper_trail

  belongs_to :superior_warrant, class_name: 'WarrantType', foreign_key: 'superior_warrant_id'
  has_attached_file :warrant_badge

  validates :name, presence: true, uniqueness: true
  validates_attachment_content_type :warrant_badge,  :content_type => /\Aimage\/.*\Z/

end
