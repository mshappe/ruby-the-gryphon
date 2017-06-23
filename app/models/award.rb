# == Schema Information
#
# Table name: awards
#
#  id                       :integer          not null, primary key
#  name                     :string
#  description              :text
#  precedence               :integer
#  award_badge_file_name    :string
#  award_badge_content_type :string
#  award_badge_file_size    :integer
#  award_badge_updated_at   :datetime
#  award_type_id            :integer
#  branch_id                :integer
#  active                   :boolean
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
# Indexes
#
#  index_awards_on_award_type_id  (award_type_id)
#  index_awards_on_branch_id      (branch_id)
#

class Award < ActiveRecord::Base
  has_paper_trail
  resourcify

  belongs_to :award_type, class_name: 'AwardType'
  belongs_to :branch
  has_many :award_recipients
  has_many :personas, through: :award_recipients
  has_attached_file :award_badge, storage: :database

  validates :name, presence: true
  validates_attachment_content_type :award_badge, content_type: /\Aimage\/.*\Z/

  delegate :name, to: :branch, prefix: true
end
