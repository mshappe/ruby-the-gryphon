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
#
# Indexes
#
#  index_posts_on_persona_id       (persona_id)
#  index_posts_on_warrant_type_id  (warrant_type_id)
#

require 'rails_helper'

RSpec.describe Post, type: :model do
  it { is_expected.to belong_to :persona }
  it { is_expected.to belong_to :post_type }
  it { is_expected.to belong_to :warrant_type }
  it { is_expected.to validate_presence_of :title }
end
