class Manage::PersonasController < Manage::ManagementController
  load_and_authorize_resource

  def show; end
  def edit; end

  def update
    @persona.update_attributes(persona_params)
    respond_with @persona, location: manage_persona_path
  end

  def destroy
    @persona.destroy
    respond_with current_user, location: manage_path
  end

  protected

  def persona_params
    params.require(:persona).permit(:user_id, :name, :honorific, :persona_type_id, :description, :name_registered, :persona_image)
  end
end
