# frozen_string_literal: true

# == Schema Information
#
# Table name: drop_down_items
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  type        :string
#  active      :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class PostType < DropDownItem
  OFFICER_PAGE_POST_TYPES = [
    'Missives',
    'Resource Links',
    'Forms',
    'Handbooks',
    'Reporting Schedules'
  ].freeze

  scope :for_officer_page, -> { where(active: true, name: OFFICER_PAGE_POST_TYPES) }
end
