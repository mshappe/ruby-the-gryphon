require 'rails_helper'

RSpec.describe OfficersController, type: :controller do
  describe 'GET #index gets only warrant types without superiors' do
    before :each do
      @great_officer = create :warrant_type, name: 'Kingdom Wombat', stallari_order: 1, superior_warrant_id: 0
      @lesser_offcier = create :warrant_type, name: 'Kingdom Deputy Wombat', stallari_order: 0, superior_warrant: @great_officer

      get :index
    end

    it 'should succeed for everyone' do
      expect(response).to be_success
      expect(assigns(:officers)).to match_array [@great_officer]
    end
  end

  describe 'GET #show' do
    before :each do
      type = create :post_type, name: 'Officer Content'
      @officer = create :warrant_type, name: 'Kingdom Wombat'
      @holder = create :person
      @warrant = create :warrant, person: @holder, warrant_type: @officer, tenure_start: 1.year.ago, approved: 1.year.ago
      @post = create :post, warrant_type: @officer, post_type: type, start_date: 3.days.ago, end_date: 3.days.from_now, approved: 1.day.ago
      create :post, warrant_type: @officer, post_type: type, start_date: 3.days.ago, end_date: 3.days.from_now, approved: nil
      create :post, warrant_type: @officer, post_type: type, start_date: 5.days.ago, end_date: 3.days.ago, approved: 4.days.ago

      get :show, id: @officer.id
    end

    it 'should succeed for everyone and show current approved posts' do
      expect(response).to be_success
      expect(assigns(:officer)).to eq @officer
      expect(assigns(:person)).to eq @warrant.person
      expect(assigns(:posts)).to match_array [@post]
    end
  end
end
