module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:adminuser]
      sign_in FactoryGirl.create(:adminuser) # Using factory girl as an example
    end
  end

  def login_user(role=nil)
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = FactoryGirl.create(:user, personas: [create(:persona)])
      @user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      @user.add_role role if role
      sign_in @user
    end
  end
end