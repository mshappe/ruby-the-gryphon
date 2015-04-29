class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource

  def index
    @events = Event.approved
    @events = @events.all_future unless params[:include] == 'past'
  end
end
