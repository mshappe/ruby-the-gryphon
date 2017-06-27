class EventsController < ApplicationController
  load_and_authorize_resource

  before_action :authenticate_user!, except: [:index, :show]
  before_action :create_nested_models, only: [:new, :edit]


  def index
    @q = @events.ransack(query)
    @events = @q.result.approved_eager
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
      ap @event.errors
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
    if @event.update_attributes(event_params)
      @event.supersedes.try(:save)
      EventNotification.notify_submitter_update(@event).deliver_later
      flash[:notice] = 'Event updated. Submitter will be notified.'
    else
      ap @event.errors
      flash[:error] = 'Your update had errors'
    end
    respond_with @event
  end

  protected

  def create_nested_models
    @event.build_address if @event.address.blank?
  end

  def enforce_submission_state
    if @event.submission_state? || cannot?(:manage, Event)
      @event.submission_state = 'queued'
    end
  end

  def event_params
    params.require(:event).permit(:name, :start_at, :end_at, :url, :branch_id, :sponsor_branch_id,
                                  :unlisted_host, :unlisted_sponsor, :site_name, :address_id, :web_ad,
                                  :comments, :admin_comments, :submitter_persona_id, :submitter_sca_name,
                                  :submitter_legal_name, :submitter_phone, :submitter_email,
                                  :steward_persona_id, :steward_sca_name, :steward_legal_name,
                                  :steward_phone, :steward_email, :submission_state, :supersedes_id, :superseded_by_id)
  end

  def query
    params.permit(q: [:name_cont]).fetch(:q, nil)
  end
end
