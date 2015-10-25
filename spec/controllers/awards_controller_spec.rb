require 'rails_helper'

RSpec.describe AwardsController, type: :controller do
  before :each do
    @branch = create :branch, name: 'B'
    @other_branch = create :branch, name: 'A'

    @awards = (0..2).collect do |n|
      create :award, precedence: 3-n, branch: @branch
    end
    @sorted_awards = @awards.sort { |x,y| x.precedence <=> y.precedence }
    @other_award = create :award, branch: @other_branch

    Rails.application.config.x.branch_name = @branch.name
  end

  after :each do
    Rails.application.config.x.branch_name = nil
    Rails.cache.clear
  end

  context 'GET #index' do
    context "without params, for all users" do
      before :each do
        get :index
      end
      it 'should succeed and show awards for the defined default branch in precedence order' do
        expect(response).to be_success
        expect(assigns[:awards].count).to eq 3
        expect(assigns[:awards]).to eq @sorted_awards
      end
    end

    context "with branch=all" do
      before :each do
        get :index, branch: 'all'
      end

      it 'should return all awards in group, then precedence order' do
        expect(response).to be_success
        expect(assigns[:awards].count).to eq 4
        expect(assigns[:awards]).to eq @sorted_awards.prepend @other_award
      end
    end

    context "with branch selected by id" do
      before :each do
        get :index, branch: { id: @other_branch.id }
      end

      it 'should return the award for that branch' do
        expect(response).to be_success
        expect(assigns[:awards].count).to eq 1
        expect(assigns[:awards]).to eq [@other_award]
      end
    end
  end

  context "GET #show" do
    before :each do
      @court = create :court
      @persona = create :persona
      @award_recipient = create :award_recipient, award: @awards.first, persona: @persona, court: @court
    end

    it 'displays award information including recipients in order most to least recent' do
      get :show, id: @awards.first

      expect(response).to be_success
      expect(assigns[:award]).to eq @awards.first
      expect(assigns[:award_recipients]).to match_array [@award_recipient]
    end
  end
end