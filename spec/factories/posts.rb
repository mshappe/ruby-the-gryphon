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

FactoryBot.define do
  factory :post do
    post_type_id 1
    persona nil
    warrant_type nil
    title "MyString"
    body "MyText"
    url "MyString"
    start_date "2017-06-02 15:24:40"
    end_date "2017-06-02 15:24:40"
    approved "2017-06-02 15:24:40"
  end
end
