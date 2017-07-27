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

FactoryGirl.define do
  factory :award_recommendation do
    association :award
    association :persona
    association :branch
    association :submitted_by_person, factory: :person
    persona_name nil
    legal_name nil
    gender nil
    persona_description "MyText"
    is_youth false
    sca_term 1
    reason "MyText"
    status 'I'
    planned_court_id 1
  end
end
