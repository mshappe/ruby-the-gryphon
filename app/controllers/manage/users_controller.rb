class Manage::UsersController < Manage::ManagementController
  load_and_authorize_resource

  def update
    @user.skip_reconfirmation!
    @user.update_attributes(user_params)
    respond_with @user, location: manage_user_path
  end

  def destroy
    @user.destroy
    respond_with @user, location: manage_path
  end

  protected

  def user_params
    p = params.require(:user).permit(:email, :password, :password_confirmation, role_ids: [], persona_ids: [],
      person_attributes: [:id, :name,
        address_attributes: [:id, :address, :city, :postal_code, :state, :country]
      ]
    )
    if p[:password].blank? && p[:password_confirmation].blank?
      p.delete(:password)
      p.delete(:password_confirmation)
    end
    p
  end
end
