require 'rails_helper'

RSpec.describe Manage::RolesController, type: :controller do
  it_behaves_like 'a management creator', :role, { name: 'wombat' }
  it_behaves_like 'a management deleter', :role

  describe 'role assigned to users' do
    before :each do
      @role = create :role, name: 'wombat'
      @victim = create :user
      @victim.add_role @role.name.to_sym
    end

    describe 'cannot be deleted' do
      login_user :admin

      before :each do
        delete :destroy, id: @role.id
      end

      it 'should fail' do
        expect(response).to redirect_to :manage
        expect(flash[:alert]).to match %r[has users assigned]
      end
    end
  end
end
