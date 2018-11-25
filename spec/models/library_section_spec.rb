# == Schema Information
#
# Table name: library_sections
#
#  id         :integer          not null, primary key
#  name       :string
#  order      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe LibrarySection, type: :model do
  it { is_expected.to have_many :library_documents }
end
