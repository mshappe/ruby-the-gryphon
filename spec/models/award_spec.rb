# == Schema Information
#
# Table name: awards
#
#  id                       :integer          not null, primary key
#  name                     :string
#  description              :text
#  precedence               :integer
#  award_badge_file_name    :string
#  award_badge_content_type :string
#  award_badge_file_size    :integer
#  award_badge_updated_at   :datetime
#  award_type_id            :integer
#  branch_id                :integer
#  active                   :boolean
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
# Indexes
#
#  index_awards_on_award_type_id  (award_type_id)
#  index_awards_on_branch_id      (branch_id)
#

require 'rails_helper'

RSpec.describe Award, :type => :model do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to belong_to :award_type }
  it { is_expected.to belong_to :branch }
end
