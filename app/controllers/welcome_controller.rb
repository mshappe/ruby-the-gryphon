class WelcomeController < ApplicationController
  before_action :get_events, only: [:index]
  skip_authorization_check

  protected

  def get_events
    @events = Event.approved.next_three_months.order(:start_at)
    @q = @events.ransack(params[:q])
    @events = @q.result
    # TODO find a better way
    @posts = Post.where.not(approved: nil)
      .where(post_type: PostType.where(name: 'Announcement'))
      .order(start_date: :desc)
      .limit(5)
  end
end
