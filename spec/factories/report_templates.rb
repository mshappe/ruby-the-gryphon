# frozen_string_literal: true

# == Schema Information
#
# Table name: report_templates
#
#  id              :integer          not null, primary key
#  warrant_type_id :integer
#  title           :string
#  fields          :jsonb
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_report_templates_on_warrant_type_id  (warrant_type_id)
#

FactoryBot.define do
  factory :report_template do
    warrant_type { nil }
    title { 'MyString' }
    fields { '' }
  end
end
