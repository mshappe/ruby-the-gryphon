class Users::RegistrationsController < Devise::RegistrationsController
# before_filter :configure_sign_up_params, only: [:create]
  before_filter :configure_account_update_params, only: [:update]
  before_filter :create_nested_models, only: [:edit]

  skip_authorization_check

# GET /resource/sign_up
# def new
#  super
#  end

# POST /resource
# def create
#   super
# end

# GET /resource/edit
# def edit
#  super
# end

# PUT /resource
#def update
# super
#end

# DELETE /resource
# def destroy
#   super
# end

# GET /resource/cancel
# Forces the session data which is usually expired after sign
# in to be expired now. This is useful if the user wants to
# cancel oauth signing in/up in the middle of the process,
# removing all OAuth session data.
# def cancel
#   super
# end

  protected

# You can put the params you want to permit in the empty array.
# def configure_sign_up_params
#   devise_parameter_sanitizer.for(:sign_up) << :attribute
# end

# You can put the params you want to permit in the empty array.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update,
      keys: [:email, :password, :password_confirmation,
             :current_password,
             person_attributes: [
                :id, :branch_id, :name, :private_email, :private_address,
                :private_phone, :private_persona,
                address_attributes: [:id, :address, :city, :state, :postal_code, :country]
              ]
            ]
    )
  end

  def create_nested_models
    resource.build_person if resource.person.blank?
    resource.person.build_address if resource.person.address.blank?
  end

# The path used after sign up.
# def after_sign_up_path_for(resource)
#   super(resource)
# end

# The path used after sign up for inactive accounts.
# def after_inactive_sign_up_path_for(resource)
#   super(resource)
# end
end
