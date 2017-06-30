class PostsController < ApplicationController
  before_filter :get_posts, only: [:index]
  load_and_authorize_resource

  protected

  def get_posts
    @post_type_name = params[:post_type_name] if params[:post_type_name]
    @search_term = params[:full_text_search] if params[:full_text_search]
    post_type = PostType.find_by!(name: @post_type_name) if @post_type_name
    @posts = Post.approved
      .where(post_type: post_type)
      .order(start_date: :desc)
      .page(params[:page]).per(10)
    @posts = @posts.search_for(@search_term) if @search_term.present?
  end
end
