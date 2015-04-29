require 'rails_helper'

RSpec.describe BranchesController, :type => :controller do
  describe '#show' do
    before :each do
      @branch = create :branch
      @event = create :event, branch: @branch, start_at: Date.tomorrow
      @other_event = create :event, sponsor_branch: @branch, start_at: 2.months.from_now
      @old_event = create :event, branch: @branch, start_at: 2.days.ago
      @someone_else_event = create :event, start_at: Date.tomorrow
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
