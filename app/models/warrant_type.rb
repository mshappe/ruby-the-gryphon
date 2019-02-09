# frozen_string_literal: true

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

class WarrantType < ActiveRecord::Base
  has_paper_trail

  belongs_to :superior_warrant, class_name: 'WarrantType', foreign_key: 'superior_warrant_id', inverse_of: :subordinate_warrants
  has_many :subordinate_warrants, class_name: 'WarrantType', foreign_key: 'superior_warrant_id', inverse_of: :superior_warrant
  has_many :posts
  has_many :warrants do
    def current
      now = DateTime.current
      approved
      .where('tenure_start < ?', now)
      .where('tenure_end IS NULL')
      .order(:tenure_start)
    end
  end
  has_attached_file :warrant_badge

  validates :name, presence: true, uniqueness: true
  validates_attachment_content_type :warrant_badge, content_type: /\Aimage\/.*\Z/

  scope :current, -> { warrants.current }
  scope :branch_offices, -> { where "name LIKE 'Branch %'" }
  scope :kingdom_offices, -> { where.not "name LIKE 'Branch %'"}
  scope :great_offices, -> { where superior_warrant_id: nil }

  def most_recent_warrant
    warrants.order(tenure_start: :desc).first
  end

  def most_recent_warranted_person
    most_recent_warrant.person
  end

  def most_recent_warranted_persona
    most_recent_warranted_person.personas.primary
  end
end
