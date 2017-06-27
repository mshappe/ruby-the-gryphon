# == Schema Information
#
# Table name: award_recipients
#
#  id                                     :integer          not null, primary key
#  award_id                               :integer
#  persona_id                             :integer
#  court_id                               :integer
#  status_id                              :integer
#  received                               :datetime
#  revoked                                :datetime
#  award_recipient_thumbnail_file_name    :string
#  award_recipient_thumbnail_content_type :string
#  award_recipient_thumbnail_file_size    :integer
#  award_recipient_thumbnail_updated_at   :datetime
#  award_recipient_image_file_name        :string
#  award_recipient_image_content_type     :string
#  award_recipient_image_file_size        :integer
#  award_recipient_image_updated_at       :datetime
#  award_content                          :text
#  creation_notes                         :text
#  reason                                 :text
#  note                                   :text
#  created_at                             :datetime         not null
#  updated_at                             :datetime         not null
#
# Indexes
#
#  index_award_recipients_on_award_id    (award_id)
#  index_award_recipients_on_court_id    (court_id)
#  index_award_recipients_on_persona_id  (persona_id)
#

class AwardRecipient < ActiveRecord::Base
  belongs_to :award
  belongs_to :persona
  belongs_to :court

  has_attached_file :award_recipient_thumbnail, storage: :database
  has_attached_file :award_recipient_image, storage: :database
  validates_attachment_content_type :award_recipient_thumbnail, content_type: /\Aimage\/.*\Z/
  validates_attachment_content_type :award_recipient_image, content_type: /\Aimage\/.*\Z/

  scope :by_award, ->(award) { where(award_id: award.id) }

  delegate :name, to: :persona, prefix: true
end
