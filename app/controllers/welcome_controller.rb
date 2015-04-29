class WelcomeController < ApplicationController
  before_action :get_events, only: [:index]

  protected

  def get_events
    @events = Event.next_three_months.order(:start_at)
  end
end
