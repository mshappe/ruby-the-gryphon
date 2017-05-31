# == Schema Information
#
# Table name: personas
#
#  id                         :integer          not null, primary key
#  user_id                    :integer
#  name                       :string
#  honorific                  :string
#  persona_type_id            :integer
#  description                :text
#  name_registered            :datetime
#  persona_image_file_name    :string
#  persona_image_content_type :string
#  persona_image_file_size    :integer
#  persona_image_updated_at   :datetime
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
# Indexes
#
#  index_personas_on_persona_type_id  (persona_type_id)
#  index_personas_on_user_id          (user_id)
#

require 'rails_helper'

RSpec.describe PersonasController, :type => :controller do
  describe 'GET new' do
    describe 'Not logged in' do
      before :each do
        get :new
      end

      it 'should fail' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'Logged in admin' do
      login_user(:admin)

      before :each do
        get :new
      end

      it 'should succeed' do
        expect(response).to have_http_status :success
        expect(response).to render_template :new
      end
    end

    describe 'Logged in and creating own' do
      login_user

      before :each do
        get :new
      end

      it 'should succeed' do
        expect(response).to have_http_status :success
        expect(response).to render_template :new
      end
    end
  end

  describe 'POST create' do
    describe 'Not logged in' do
      before :each do
        post :create, { user_id: 42, name: 'Wombat von Wombatlips' }
      end

      it 'should fail' do
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'Logged in and creating a new persona for self' do
      login_user

      before :each do
        @type = create :persona_type
        post :create, persona: { user_id: controller.current_user.id, name: 'Wombat von Wombatlips´', persona_type_id: @type.id }
      end

      it 'should succeed' do
        expect(response).to have_http_status :redirect
        expect(response).to redirect_to Persona.last
        is_expected.to set_flash.to %r[created]
      end
    end

    describe 'Logged in and trying to hack a new persona for someone else' do
      login_user

      before :each do
        @type = create :persona_type
      end

      it 'should fail' do
        post :create, persona: { user_id: 42,
                                 name: 'Wombat von Wombatlips´',
                                 persona_type_id: @type.id }
        expect(response).to redirect_to root_url
      end
    end

    describe 'PATCH update' do
      login_user

      describe 'updating one of your own personae' do
        before :each do
          @persona = create :persona, user: controller.current_user
          patch :update, id: @persona.id, persona: { description: 'Beware the viscous giraffe' }
          @persona.reload
        end

        it 'should succeed' do
          expect(response).to have_http_status :redirect
          expect(response).to redirect_to @persona
          expect(@persona.description).to eq 'Beware the viscous giraffe'
          is_expected.to set_flash.to %r[updated]
        end
      end
    end

    describe 'DELETE destroy' do
      login_user

      describe 'deleting one of your own personae' do
        before :each do
          @persona = create :persona, user: controller.current_user
          delete :destroy, id: @persona.id
        end

        it 'should succeed' do
          expect(response).to have_http_status :redirect
          expect(response).to redirect_to edit_user_registration_path @controller.current_user
          is_expected.to set_flash.to %r[destroyed]
        end
      end
    end
  end
end
