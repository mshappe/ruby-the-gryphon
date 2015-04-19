class PersonasController < ApplicationController
  respond_to :html, :json

  before_action :authenticate_user!
  load_and_authorize_resource

  def create
    @persona = Persona.create(persona_params)
    respond_with @persona
  end

  def update
    @persona.update_attributes(persona_params)
    respond_with @persona
  end

  def destroy
    @persona.destroy
    respond_with current_user, location: edit_user_registration_path(current_user)
  end

  protected

  def persona_params
    params.require(:persona).permit(:user_id, :name, :honorific, :persona_type_id, :description, :name_registered, :persona_image)
  end

  def interpolation_options
    { resource_name: @persona.name }
  end
end
