class Manage::WarrantsController < Manage::ManagementController
  load_and_authorize_resource

  def update
    @warrant.update_attributes(warrant_params)
    respond_with @warrant, location: :manage_warrant
  end

  def destroy
    @warrant.destroy
    respond_with @warrant, location: :manage
  end

  protected

  def warrant_params
    params.require(:warrant).permit(:branch_id, :tenure_start, :tenure_end, :approved, :introduction, :comments)
  end
end
