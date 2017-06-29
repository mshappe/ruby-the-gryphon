require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'get #show' do
    describe 'approved posts' do
      before :each do
        @post = create :post, approved: 3.days.ago
        get :show, id: @post.id
      end

      it 'should succeed' do
        expect(response).to be_success
        expect(assigns(:post)).to eq @post
      end
    end

    describe 'unapproved posts' do
      before :each do
        @post = create :post, approved: nil, persona_id: 42
      end

      describe 'for anonymous' do
        before :each do
          get :show, id: @post.id
        end

        it 'should redirect' do
          expect(response).to be_redirect
          expect(response).to redirect_to :root
        end
      end

      describe 'for non-owner' do
        login_user

        before :each do
          @user.personas.create(name: 'Wombat')
          get :show, id: @post.id
        end

        it 'should redirect' do
          expect(response).to be_redirect
          expect(response).to redirect_to :root
        end
      end
    end
  end

end
