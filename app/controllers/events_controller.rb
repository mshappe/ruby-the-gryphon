class EventsController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user!, except: [:index, :show]
  before_action :create_nested_models, only: [:new, :edit]


  def index
    @events = Event.approved
    @events = @events.all_future unless params[:include] == 'past'
  end

  def queued
    @events = Event.queued
  end

  def create
    enforce_submission_state

    if @event.save
      EventNotification.notify_submitter(current_user, @event).deliver_later
      flash[:notice] = 'Event submitted. It will be reviewed by the Event Information Officer.'
    else
      flash[:error] = 'Your submission had errors.'
    end
    respond_with @event
  end

  def edit
    unless can? :manage, Event
      @event = @event.dup
      @event.submission_state = 'queued'
    end
  end

  def update
    if @event.submission_state == 'queued' && event_params['submission_state'] == 'approved' &&
        @event.supersedes.try(:submission_state) == 'approved'
      @event.supersedes.retire(@event)
    end

    if @event.update_attributes(event_params)
      @event.supersedes.try(:save)
      EventNotification.notify_submitter_update(@event).deliver_later
      flash[:notice] = 'Event updated. Submitter will be notified.'
    else
      flash[:error] = 'Your update had errors'
    end
    respond_with @event
  end

  protected

  def create_nested_models
    @event.build_address if @event.address.blank?
  end

  def enforce_submission_state
    unless can? :manage, Event
      @event.submission_state = 'queued'
    end
  end

  def event_params
    params.require(:event).permit! # TODO
  end
end
