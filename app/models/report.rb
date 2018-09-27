# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id              :integer          not null, primary key
#  post_type_id    :integer
#  persona_id      :integer
#  warrant_type_id :integer
#  title           :string(200)
#  body            :text
#  url             :string(200)
#  start_date      :datetime
#  end_date        :datetime
#  approved        :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  type            :string           default("Post")
#  body_fields     :jsonb
#
# Indexes
#
#  index_posts_on_persona_id       (persona_id)
#  index_posts_on_type             (type)
#  index_posts_on_warrant_type_id  (warrant_type_id)
#

class BodyFieldsValidator < ActiveModel::EachValidator
  def validate_each(record, _attribute, _value)
    unless record.fields.blank? || record.fields.is_a?(Array)
      record.errors[:body_fields] << 'fields can be blank or must be an array or report field structures'
      return
    end

    record.fields&.each do |f|
      unless f.is_a?(Hash)
        record.errors[:body_fields] << 'fields must be JSON objects [hashes]'
        return
      end
      unless f.key?(:title) && f.key?(:text)
        record.errors[:body_fields] << 'Each field record must have a title and text'
      end
      unless (f.keys - Report::FIELD_KEYS).blank?
        record.errors[:body_fields] << 'Each field record can only have a title and text'
      end
    end
  end
end

class Report < Post
  FIELD_KEYS = %i[title text].freeze

  belongs_to :report_type, foreign_key: 'post_type_id', class_name: 'ReportType'
  has_one :report_template, through: :warrant_type

  validates :body_fields, body_fields: true

  store_accessor :body_fields, :fields
end
