class Manage::ReignsController < Manage::ManagementController
  load_and_authorize_resource
  before_filter :get_reign_events, only: [:new, :edit]

  def show; end
  def new; end
  def edit; end

  def create
    # Reign IDs are weird. For Hysterical Raisins, Principality reign IDs are negative.
    # This screws up auto-increment in Postgres
    @reign.id = next_id
    if @reign.save
      flash[:notice] = 'New reign created'
    else
      flash[:error] = 'Reign could not be created'
    end
    respond_with @reign, location: manage_path
  end

  def update
    @reign.update_attributes(reign_params)
    respond_with @reign, location: manage_reign_path(@reign)
  end

  protected

  def reign_params
    params.require(:reign).permit(:name, :combatant_persona_id, :consort_persona_id,
      :crown_event_id, :coronation_event_id, :url,
      :runner_up_persona_id, :runner_up_consort_persona_id,
      :reign_image, :reign_map)
  end

  def get_reign_events
    @crowns = Event.where('name ILIKE ?', '%Crown Tour%').select(:id, :name, :start_at).order(start_at: :desc)
    @coronations = Event.where('name ILIKE ?', '%Coronation%').select(:id, :name, :start_at).order(start_at: :desc)
  end

  def next_id
    (Reign.order(id: :asc).last.try(:id) || 0) + 1
  end
end
