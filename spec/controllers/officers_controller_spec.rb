# frozen_string_literal: true

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
      @warrant = create :warrant, person: @holder, warrant_type: @officer, tenure_start: 1.year.ago, submission_state: 'approved', approved_date: 1.year.ago
      @post = create :post, warrant_type: @officer, post_type: type, start_date: 3.days.ago, end_date: 3.days.from_now, approved: 1.day.ago
      create :post, warrant_type: @officer, post_type: type, start_date: 3.days.ago, end_date: 3.days.from_now, approved: nil
      create :post, warrant_type: @officer, post_type: type, start_date: 5.days.ago, end_date: 3.days.ago, approved: 4.days.ago

      get :show, id: @officer.id
    end

    it 'should succeed for everyone and show current approved posts' do
      expect(response).to be_success
      expect(assigns(:officer)).to eq @officer
      expect(assigns(:subordinate_officers)).to be_empty
      expect(assigns(:person)).to eq @warrant.person
      expect(assigns(:posts)).to match_array [@post]
    end
  end

  describe 'GET #change_process' do
    before :each do
      get :change_process
    end

    it 'should succeed' do
      expect(response).to be_success
    end
  end

  describe 'GET #search JSON' do
    let!(:kingdom_office) { create :warrant_type }
    let!(:branch_office) { create :warrant_type, name: "Branch #{Faker::Name.name}"}
    let(:all) { [kingdom_office, branch_office] }

    describe 'no query string' do
      before :each do
        xhr :get, :search, format: :json
      end

      it 'should get all' do
        expect(response).to be_success
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json.count).to eq 2
      end
    end

    describe 'with q=kingdom' do
      before :each do
        xhr :get, :search, q: 'kingdom', format: :json
      end

      it 'should get only the non-branch' do
        expect(response).to be_success
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json.count).to eq 1
        expect(json.first[:name]).to eq kingdom_office.name
      end
    end

    describe 'with q=branch' do
      before :each do
        xhr :get, :search, q: 'branch', format: :json
      end

      it 'should get only the branch' do
        expect(response).to be_success
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json.count).to eq 1
        expect(json.first[:name]).to eq branch_office.name
      end
    end
  end
end
