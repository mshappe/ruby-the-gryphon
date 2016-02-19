class DashboardController < ApplicationController
  before_action :get_dashboard_data

  protected

  def get_dashboard_data
    @user = User.find params[:user_id]
    authorize! :read, @user

    @events = current_user.personas.includes(:events).map { |p| p.events.next_three_months }.flatten
    @awards = current_user.personas.includes(:received_awards).map(&:received_awards).flatten.sort { |a, b| a.received <=> b.received }
    @auths = current_user.authorizations.includes(:authorization_type).sort { |a, b| a.authorization_type.group <=> b.authorization_type.group }
    @warrants = current_user.warrants.includes(:warrant_type).order(:tenure_start)
  end

end
