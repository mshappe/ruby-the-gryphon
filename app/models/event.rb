# frozen_string_literal: true

# == Schema Information
#
# Table name: events
#
#  id                   :integer          not null, primary key
#  name                 :string
#  start_at             :datetime
#  end_at               :datetime
#  url                  :string
#  branch_id            :integer
#  sponsor_branch_id    :integer
#  unlisted_host        :string
#  unlisted_sponsor     :string
#  site_name            :string
#  address_id           :integer
#  web_ad               :text
#  comments             :text
#  admin_comments       :text
#  submitter_persona_id :integer
#  submitter_sca_name   :string
#  submitter_legal_name :string
#  submitter_phone      :string
#  submitter_email      :string
#  steward_persona_id   :integer
#  steward_sca_name     :string
#  steward_legal_name   :string
#  steward_phone        :string
#  steward_email        :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  submission_state     :string
#  supersedes_id        :integer
#  superseded_by_id     :integer
#
# Indexes
#
#  index_events_on_address_id            (address_id)
#  index_events_on_branch_id             (branch_id)
#  index_events_on_sponsor_branch_id     (sponsor_branch_id)
#  index_events_on_steward_persona_id    (steward_persona_id)
#  index_events_on_submission_state      (submission_state)
#  index_events_on_submitter_persona_id  (submitter_persona_id)
#

class Event < ActiveRecord::Base
  include Submittable

  has_paper_trail
  resourcify

  belongs_to :branch
  belongs_to :sponsor_branch, class_name: 'Branch'
  belongs_to :address
  belongs_to :submitter_persona, class_name: 'Persona'
  belongs_to :steward_persona, class_name: 'Persona'

  has_and_belongs_to_many :event_activities, class_name: 'EventActivity', join_table: :event_event_activity
  has_many :event_attendees
  has_many :attendees, class_name: 'Persona', through: :event_attendees, foreign_key: 'persona_id'

  accepts_nested_attributes_for :address

  validates :name, presence: true
  validates :start_at, presence: true
  validates :end_at, presence: true

  scope :next_three_months, -> { where end_at: (Date.today..3.months.from_now) }
  scope :all_future, -> { where 'start_at >= ?', Date.today }
  scope :approved_eager, -> { approved.includes(:branch, :address).order(:start_at) }

  delegate :name, to: :branch, prefix: true

  def name_and_date
    "#{name} #{start_at.to_date}"
  end
end
