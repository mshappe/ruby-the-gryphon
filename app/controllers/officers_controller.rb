class OfficersController < ApplicationController
  before_filter :get_officers, only: [:index]
  before_filter :get_officer, only: [:show]
  skip_authorization_check only: [:index, :show]

  protected

  def get_officers
    @officers = WarrantType.where('stallari_order > ?', 0).where(superior_warrant_id: [0, nil])
  end

  def get_officer
    @officer = WarrantType.find(params[:id])
    @person = Warrant.current_holders_by_type(@officer).last.person
    now = DateTime.current
    @posts = @officer.posts.where('start_date < ?', now)
      .where('end_date > ? OR end_date IS NULL', now)
      .where.not(approved: nil)
    @post_types = PostType.for_officer_page
  end
end
