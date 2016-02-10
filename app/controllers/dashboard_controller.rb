class DashboardController < ApplicationController
  before_action :get_dashboard_data

  protected

  def get_dashboard_data
    @user = User.find params[:user_id]
    authorize! :read, @user

    @events = current_user.personas.map { |p| p.events.next_three_months }.flatten
    @awards = current_user.personas.map(&:received_awards).flatten.sort { |a, b| a.received <=> b.received }
  end

end
