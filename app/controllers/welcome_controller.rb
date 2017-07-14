class WelcomeController < ApplicationController
  before_action :get_events, only: [:index]
  skip_authorization_check

  protected

  def get_events
    @q = Event.ransack(params[:q])
    @events = @q.result
      .approved
      .next_three_months.order(:start_at)

    @posts = Post.approved
      .announcements
      .order(start_date: :desc)
      .limit(5)

    @trm = Reign.includes(:coronation_event).where('events.start_at < ?', DateTime.now).order('events.start_at DESC').first
    @trh = Reign.includes(:crown_event).where('events.start_at < ?', DateTime.now).order('events.start_at DESC').first
    @trh = nil if @trh == @trm
  end
end
