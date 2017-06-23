# == Schema Information
#
# Table name: branches
#
#  id                           :integer          not null, primary key
#  name                         :string
#  branch_type_id               :integer
#  region_id                    :integer
#  map_coordinates              :string
#  parent_branch_id             :integer
#  city                         :string
#  state                        :string
#  url                          :string
#  active                       :boolean
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  branch_heraldry_file_name    :string
#  branch_heraldry_content_type :string
#  branch_heraldry_file_size    :integer
#  branch_heraldry_updated_at   :datetime
#  map_image_file_name          :string
#  map_image_content_type       :string
#  map_image_file_size          :integer
#  map_image_updated_at         :datetime
#
# Indexes
#
#  index_branches_on_branch_type_id    (branch_type_id)
#  index_branches_on_name              (name) UNIQUE
#  index_branches_on_parent_branch_id  (parent_branch_id)
#

require 'rails_helper'

RSpec.describe Branch, :type => :model do
  it { is_expected.to belong_to :branch_type }
  it { is_expected.to belong_to :region }
  it { is_expected.to belong_to :parent_branch }
  it { is_expected.to have_many :child_branches }
  it { is_expected.to have_many :awards }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_uniqueness_of :name }
  it { is_expected.to validate_presence_of :branch_type }
  it { is_expected.to validate_presence_of :region }

  context '::default_branch' do
    after :each do
      Rails.application.config.x.branch_name = nil
      Rails.cache.clear
    end

    context 'a default is defined in application config' do
      before :each do
        Rails.application.config.x.branch_name = 'Erewhon'
      end

      context 'but is not defined in database' do
        it 'should return nil and log an error' do
          expect(Rails.logger).to receive(:error).with(%r[could not find branch named.*in database]i)
          expect(Branch.default_branch).to be_nil
        end
      end

      context 'and is defined in database' do
        before :each do
          create :region
          create :branch, name: 'Erewhon'
        end
        it 'should return the default branch' do
          expect(Branch.default_branch).to_not be_nil
          expect(Branch.default_branch.name).to eq 'Erewhon'
        end
      end
    end

    context 'is not defined in application config' do
      before :each do
        Rails.application.config.x.branch_name = nil # in case we have one defined in defaults.yml
      end

      it 'should return nil and log an error' do
        expect(Rails.logger).to receive(:error).with(%r[no default branch name defined]i)
        expect(Branch.default_branch).to be_nil
      end
    end
  end
end
