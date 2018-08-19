# == Schema Information
#
# Table name: treaties
#
#  id                :integer          not null, primary key
#  persona_id        :integer
#  treaty_type_id    :integer
#  treaty_type_type  :string
#  reign_id          :integer
#  foreign_branch_id :integer
#  user_comment      :text
#  royal_comment     :text
#  foreign_comment   :text
#  royal_approved    :datetime
#  foreign_approved  :datetime
#  royal_status      :string(1)
#  foreign_status    :string(1)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_treaties_on_foreign_branch_id                    (foreign_branch_id)
#  index_treaties_on_persona_id                           (persona_id)
#  index_treaties_on_reign_id                             (reign_id)
#  index_treaties_on_treaty_type_type_and_treaty_type_id  (treaty_type_type,treaty_type_id)
#

FactoryBot.define do
  factory :treaty do
    persona { nil }
    treaty_type { "" }
    reign { nil }
    foreign_branch_id { 1 }
    user_comment { "MyText" }
    royal_comment { "MyText" }
    foreign_comment { "MyText" }
    royal_approved { "2017-06-02 14:50:14" }
    foreign_approved { "2017-06-02 14:50:14" }
    royal_status { "" }
    foreign_status { "" }
  end
end
