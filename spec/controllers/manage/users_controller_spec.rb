require 'rails_helper'

RSpec.describe Manage::UsersController, type: :controller do

  it_behaves_like 'a management controller', :edit, :user

  describe 'patch #update' do
    before :each do
      @victim = create :user
    end
    describe 'for anonymous' do
      before :each do
        patch :update, id: @victim.id, user: { email: 'wombat@face.com' }
      end

      it 'should redirect' do
        expect(response).to redirect_to :new_user_session
      end
    end

    describe 'for ordinary user' do
      login_user

      before :each do
        patch :update, id: @victim.id, user: { email: 'wombat@face.com' }
      end

      it 'should redirect' do
        expect(response).to redirect_to :root
      end
    end

    describe 'for admin user' do
      login_user :admin

      before :each do
        patch :update, id: @victim.id, user: { email: 'wombat@face.com' }
      end

      it 'should redirect' do
        expect(response).to redirect_to :manage
        expect(@victim.reload.email).to eq 'wombat@face.com'
      end
    end

  end
end
