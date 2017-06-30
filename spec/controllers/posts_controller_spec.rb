require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'get #index'do
    before :each do
      @post_type = create :post_type, name: 'Announcement'
      @post = create :post, post_type: @post_type, start_date: 3.days.ago, approved: 3.days.ago
      @other_post_type = create :post_type
      @other_post = create :post, post_type: @other_post_type, start_date: 2.days.ago, approved: 2.days.ago
      get :index, q: { post_type_name_eq: 'Announcement' }
    end

    it "should get the type that's searched for" do
      expect(response).to be_success
      expect(assigns(:posts)).to match_array [@post]
    end
  end

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
