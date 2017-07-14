class Manage::RolesController < Manage::ManagementController
  load_and_authorize_resource

  def create
    if @role.save
      flash[:notice] = 'Role Added'
    else
      flash[:error] = 'Role could not be added'
    end
    respond_with @role, location: manage_path
  end

  def destroy
    if @role.users.count > 0
      redirect_to manage_url, alert: "Role #{@role.name} has users assigned"
    else
      @role.destroy
      respond_with @role, location: manage_path
    end
  end

  protected

  def role_params
    params.require(:role).permit(:name)
  end
end
