require 'rails_helper'

RSpec.describe EventsController, :type => :controller do
  before :each do
    Event.destroy_all # I have no idea where the stray event is coming from and I don't care.
    @unapproved_event = create :event, start_at: Date.tomorrow, approved: false
    @good_event = create :event, start_at: Date.tomorrow
    @old_event = create :event, start_at: 2.days.ago
    @future_event = create :event, start_at: 4.months.from_now
  end

  describe 'GET #index (without params) for all users' do
    before :each do
      get :index
    end
    it 'should succeed just fine and show only future events by default' do
      expect(response).to be_success
      expect(assigns[:events]).to match_array [@good_event, @future_event]
    end
  end

  describe 'GET #index(include: :past) for all users' do
    before :each do
      get :index, include: 'past'
    end
    it 'should succeed just fine and show all approved events' do
      expect(response).to be_success
      expect(assigns[:events]).to match_array [@good_event, @old_event, @future_event]
    end

  end

end