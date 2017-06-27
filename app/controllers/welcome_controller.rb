class WelcomeController < ApplicationController
  before_action :get_events, only: [:index]
  skip_authorization_check

  protected

  def get_events
    @events = Event.approved.next_three_months.order(:start_at)
    @q = @events.ransack()
  end
end
