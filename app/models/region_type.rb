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

class RegionType < DropDownItem
end
