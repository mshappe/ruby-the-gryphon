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
#  type            :string           default("Post")
#  body_fields     :jsonb
#
# Indexes
#
#  index_posts_on_persona_id       (persona_id)
#  index_posts_on_type             (type)
#  index_posts_on_warrant_type_id  (warrant_type_id)
#

require 'rails_helper'

RSpec.describe Report, type: :model do
  it { is_expected.to belong_to :post_type }
  it { is_expected.to belong_to :persona }
  it { is_expected.to belong_to :warrant_type }

  describe 'body fields' do
    before :each do
      subject.title = Faker::Dune.saying
    end

    it 'should be populated with nil or an array for fields' do
      expect(subject).to be_valid

      subject.fields = []
      expect(subject).to be_valid

      subject.fields = 'lizard'
      expect(subject).to be_invalid
    end

    it 'should have records with valid keys' do
      subject.fields = [
        { title: Faker::Dune.saying, text: Faker::Lorem.paragraph }
      ]
      expect(subject).to be_valid

      subject.fields = [
        { wombat: 'lizard' }
      ]
      expect(subject).to be_invalid

      subject.fields = [ 'lizard' ]
      expect(subject).to be_invalid
    end
  end
end
