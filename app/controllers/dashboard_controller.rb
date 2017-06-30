class DashboardController < ApplicationController
  before_action :get_dashboard_data

  protected

  def get_dashboard_data
    @user = User.find params[:user_id]
    authorize! :read, @user

    @events = @user.personas.includes(:events).map { |p| p.events.next_three_months }.flatten
    @awards = @user.personas.includes(:received_awards).map(&:received_awards).flatten.sort { |a, b| a.received <=> b.received }
    @auths = @user.authorizations.includes(:authorization_type).sort { |a, b| a.authorization_type.martial_activity_type_id <=> b.authorization_type.martial_activity_type_id }
    @warrants = @user.warrants.includes(:warrant_type).order(:tenure_start)
  end

end
