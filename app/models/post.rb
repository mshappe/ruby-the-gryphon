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

class Post < ActiveRecord::Base
  belongs_to :persona
  belongs_to :post_type
  belongs_to :warrant_type
  validates :title, presence: true

  delegate :name, to: :persona, prefix: true

  paginates_per 5

  scope :approved, ->() { where.not(approved: nil) }
  scope :announcements, ->() { joins(:post_type).where(drop_down_items: { type: 'PostType', name: 'Announcement' } )}
end
