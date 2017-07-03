require 'rails_helper'

RSpec.shared_examples 'a management controller' do |action=:index, fact|
  describe "get ##{action}" do
    let(:thing) { create fact }
    describe 'anonymous' do
      it 'redirect tp root' do
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
