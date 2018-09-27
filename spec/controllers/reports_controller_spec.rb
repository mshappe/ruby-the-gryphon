# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id              :integer          not null, primary key
#  post_type_id    :integer
#  persona_id      :integer
#  warrant_type_id :integer
#  title           :string(200)
#  body            :text
#  url             :string(200)
#  start_date      :datetime
#  end_date        :datetime
#  approved        :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  type            :string           default("Post")
#  body_fields     :jsonb
#
# Indexes
#
#  index_posts_on_persona_id       (persona_id)
#  index_posts_on_type             (type)
#  index_posts_on_warrant_type_id  (warrant_type_id)
#

require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
  describe 'GET :new' do
    login_user

    describe 'with a warrant-type pre-filled' do
      let(:warrant_type) { create :warrant_type }
      let!(:warrant) { create :warrant, warrant_type: warrant_type, user: @user }
      
      before do
        get :new, report: { warrant_type_id: warrant_type.id }
      end

      it 'should route and prefill' do
        ap warrant
        expect(response).to have_http_status :success
        expect(assigns(:report).warrant_type_id).to_eq warrant_type.id
      end
    end
  end
end
