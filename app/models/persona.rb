# == Schema Information
#
# Table name: personas
#
#  id                         :integer          not null, primary key
#  user_id                    :integer
#  name                       :string
#  honorific                  :string
#  persona_type_id            :integer
#  description                :text
#  name_registered            :datetime
#  persona_image_file_name    :string
#  persona_image_content_type :string
#  persona_image_file_size    :integer
#  persona_image_updated_at   :datetime
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
# Indexes
#
#  index_personas_on_persona_type_id  (persona_type_id)
#  index_personas_on_user_id          (user_id)
#

class Persona < ActiveRecord::Base
  has_paper_trail
  has_attached_file :persona_image, storage: :database

  belongs_to :user
  belongs_to :persona_type
end
