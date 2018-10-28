# frozen_string_literal: true

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
#  index_branches_on_name              (name)
#  index_branches_on_parent_branch_id  (parent_branch_id)
#

require 'rails_helper'

RSpec.describe BranchesController, type: :controller do

  describe '#index' do
    before :each do
      @parent_branch = create :branch, parent_branch: nil
      Rails.application.config.x.branch_name = @parent_branch.name
      Rails.application.config.x.branch_type = @parent_branch.branch_type.name

      @branches = create_list :branch, 3, parent_branch: @parent_branch
      @canton = create :branch, parent_branch: @branches.first
      @someone_elses_branch = create :branch

      get :index
    end

    it 'should succeed for everybody' do
      expect(response).to be_success
    end

    it 'should contain only this kingdoms branches' do
      expect(assigns[:branches]).to include *@branches # Note the splat. Include is weird. 
      expect(assigns[:branches]).to_not include @someone_elses_branch
    end

    it 'should include subsidiary branches' do
      expect(assigns[:branches]).to include @canton
    end
  end

  describe '#show' do
    before :each do
      @branch = create :branch
      @event = create :event, branch: @branch, start_at: Date.tomorrow, end_at: Date.tomorrow
      @other_event = create :event, sponsor_branch: @branch, start_at: 2.months.from_now, end_at: 2.months.from_now
      @old_event = create :event, branch: @branch, start_at: 2.days.ago, end_at: 2.days.ago
      @someone_else_event = create :event, start_at: Date.tomorrow, end_at: Date.tomorrow
      get :show, id: @branch.id
    end

    it 'should succeed' do
      expect(response).to be_success
    end

    it 'should have the events defined above in @events' do
      expect(assigns[:events]).to match_array [@event, @other_event]
      expect(assigns[:events]).to_not match_array [@old_event, @someone_else_event]
    end
  end
end
