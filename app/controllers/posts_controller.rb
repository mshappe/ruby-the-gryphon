class PostsController < ApplicationController
  before_filter :get_posts, only: [:index]
  load_and_authorize_resource

  protected

  def get_posts
    @q = Post.joins(:post_type).approved.ransack(params[:q])
    @posts = @q.result.order(start_date: :desc).page(params[:page]).per(10)
  end
end
