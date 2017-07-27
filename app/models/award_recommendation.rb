# == Schema Information
#
# Table name: award_recommendations
#
#  id                     :integer          not null, primary key
#  award_id               :integer
#  persona_id             :integer
#  persona_name           :string
#  legal_name             :string
#  branch_id              :integer
#  gender                 :string
#  persona_description    :text
#  is_youth               :boolean
#  sca_term               :integer
#  reason                 :text
#  status                 :string
#  planned_court_id       :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  submitted_by_person_id :integer
#
# Indexes
#
#  index_award_recommendations_on_award_id          (award_id)
#  index_award_recommendations_on_branch_id         (branch_id)
#  index_award_recommendations_on_persona_id        (persona_id)
#  index_award_recommendations_on_planned_court_id  (planned_court_id)
#

class MutualExclusionValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, _value)
    if record[:persona_id].blank? && record[:persona_name].blank?
      record.errors[attribute] << 'You must specify a persona either via dropdown or via the blank below'
    elsif record[:persona_id].present? && record[:persona_name].present?
      record.errors[attribute] << 'You must either choose from the dropdown or enter a name, not both'
    end
  end
end

class AwardRecommendation < ActiveRecord::Base
  # Because Kit...there's no other reason we can fathom
  STATUS_HIDE = 'H'
  STATUS_SHOW = 'I'

  belongs_to :award
  belongs_to :persona
  belongs_to :branch
  belongs_to :planned_court, class_name: 'Court', foreign_key: 'planned_court_id'
  belongs_to :submitted_by_person, class_name: 'Person', foreign_key: 'submitted_by_person_id'

  validates :status, inclusion: [STATUS_HIDE, STATUS_SHOW]
  validates :persona, mutual_exclusion: true
  validates :branch, presence: true, if: ->(ar) { ar.persona.blank? }
  validates :legal_name, presence: true, if: ->(ar) { ar.persona.blank? }
  validates :award, presence: true
  validates :reason, presence: true

  delegate :name, to: :award, prefix: true

  def persona_name
    return persona.name if persona.present?
    self[:persona_name]
  end

  def person_name
    return persona.person.name if persona.present? && persona.person.present?
    self[:legal_name]
  end

  def branch_name
    return persona.person.branch.name if persona.present? && persona.person.present? && persona.person.branch.present?
    return branch.name if branch.present?
    ''
  end

  def gender
    return persona.person.gender if persona.present? && persona.person.present?
    self[:gender]
  end

  def submitter_persona_name
    return submitted_by_person.personas.primary.name if submitted_by_person.present? && submitted_by_person.personas.count > 0
    ''
  end

  def submitter_person_name
    return submitted_by_person.name if submitted_by_person.present? && submitted_by_person.present?
    ''
  end
end
