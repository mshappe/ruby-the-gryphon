# frozen_string_literal: true

module ControllerMacros
  def login_user(role = nil)
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      @user = FactoryBot.create(:user, person: create(:person), personas: [create(:persona)])
      @user.confirm # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      @user.add_role role if role
      sign_in @user
    end

    after(:each) do
      sign_out @user
    end
  end
end
