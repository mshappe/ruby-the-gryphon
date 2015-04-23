class WelcomeController < ApplicationController
  before_action :get_events, only: [:index]

  protected

  def get_events
    @events = Event.where(start_at: (Date.today..3.months.from_now)).order(:start_at)
  end
end
