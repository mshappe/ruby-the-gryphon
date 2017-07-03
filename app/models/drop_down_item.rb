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

class DropDownItem < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
end

class AwardScribeType < DropDownItem
end

class AwardType < DropDownItem
end

class ImageType <DropDownItem
end

class Report < DropDownItem
end

class TreatyType < DropDownItem
end
