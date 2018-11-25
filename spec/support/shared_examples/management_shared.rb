# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'a management controller' do |action, fact|
  describe "get ##{action}" do
    let(:thing) { create fact }
    describe 'anonymous' do
      it 'redirect to root' do
        get action, id: thing.id
        expect(response).to be_redirect
      end
    end

    describe 'not admin' do
      login_user

      it 'redirect to root' do
        get action, id: thing.id
        expect(response).to be_redirect
      end
    end

    describe 'as admin' do
      login_user(:admin)

      it 'should succeed' do
        get action, id: thing.id
        expect(response).to be_success
      end
    end
  end
end

RSpec.shared_examples 'a management creator' do |fact, params|
  describe 'post #create' do
    describe 'for anonymous users' do
      before :each do
        post :create, fact => params
      end

      it 'should redirect to login' do
        expect(response).to redirect_to :new_user_session
      end
    end

    describe 'for ordinary users' do
      login_user

      before :each do
        post :create, fact => params
      end

      it 'should redirect to root' do
        expect(response).to redirect_to :root
      end
    end

    describe 'for admins' do
      login_user :admin

      before :each do
        @klass = fact.to_s.classify.constantize
        @count = @klass.count
        post :create, fact => params
      end

      it 'should create and redirect to manage' do
        expect(response).to redirect_to manage_path
        expect(@klass.count).to eq @count + 1
      end
    end
  end
end

RSpec.shared_examples 'a management updater' do |fact, params, test_attr|
  describe 'patch #update' do
    before :each do
      @victim = create fact
    end

    describe 'for anonymous users' do
      before :each do
        patch :update, id: @victim.id, fact => params
      end

      it 'should redirect to login' do
        expect(response).to redirect_to :new_user_session
      end
    end

    describe 'for ordinary users' do
      login_user

      before :each do
        patch :update, id: @victim.id, fact => params
      end

      it 'should redirect to root' do
        expect(response).to redirect_to :root
      end
    end

    describe 'for admins' do
      login_user :admin

      before :each do
        patch :update, id: @victim.id, fact => params
      end

      it 'should update and redirect to show' do
        expect(response).to redirect_to "manage_#{fact}".to_sym
        expect(@victim.reload.send(test_attr).to_s).to eq params[test_attr.to_sym].to_s
      end
    end
  end
end

RSpec.shared_examples 'a management deleter' do |fact|
  describe 'delete #destroy' do
    before :each do
      @victim = create fact
    end

    describe 'for anonymous users' do
      before :each do
        delete :destroy, id: @victim.id
      end

      it 'should redirect to login' do
        expect(response).to redirect_to :new_user_session
      end
    end

    describe 'for ordinary users' do
      login_user

      before :each do
        delete :destroy, id: @victim.id
      end

      it 'should redirect to root' do
        expect(response).to redirect_to :root
      end
    end

    describe 'for admin users' do
      login_user :admin

      before :each do
        @count = @victim.class.count
        delete :destroy, id: @victim.id
      end

      it 'should delete and redirect to manage' do
        expect(response).to redirect_to :manage
        expect(@victim.class.count).to eq @count - 1
      end
    end
  end
end
