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

class FieldsValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless record.report_fields.blank? || record.report_fields.is_a?(Array)
      record.errors[:report_fields] << 'must be empty or an Array'
      return
    end

    record.report_fields&.each do |rf|
      unless rf.keys.include?(:type) && rf.keys.include?(:title)
        record.errors[:report_fields] << "must include a :type and :title"
      end
      unless ReportTemplate::FIELD_TYPES.include?(rf[:type])
        record.errors[:report_fields] << "type must be one of 'text' or 'choice'"
      end
      if rf[:type] == 'choice'
        unless rf.keys.include?(:choices)
          record.errors[:report_fields] << 'choice type must included choices field'
          next
        end
        unless rf[:choices].is_a?(Array)
          record.errors[:report_fields] << 'choices must be an array of strings'
          next
        end
      end
      unless (rf.keys - ReportTemplate::FIELD_KEYS).blank?
        record.errors[:report_fields] << "keys must be one of #{ReportTemplate::FIELD_KEYS}"
      end
    end
  end
end

class ReportTemplate < ActiveRecord::Base
  FIELD_TYPES = %w(text choice)
  FIELD_KEYS = %i(type title choices)

  belongs_to :warrant_type

  validates :title, presence: true, uniqueness: true
  validates :fields, fields: true

  store_accessor :fields, :report_fields
end
