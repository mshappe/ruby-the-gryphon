# frozen_string_literal: true

class OfficersController < ApplicationController
  before_filter :get_officers, only: [:index]
  before_filter :get_officer, only: [:show]
  skip_authorization_check only: %i[index show warrant_badges]

  downloads_files_for :warrant_type, :warrant_badge

  def index; end

  def show; end

  protected

  def get_officers
    @officers = WarrantType.where('stallari_order > ?', 0).where(superior_warrant_id: [0, nil]).order(:stallari_order)
  end

  def get_officer
    @officer = WarrantType.find(params[:id])
    @person = @officer.warrants.current.last.person
    @subordinate_officers = WarrantType.where(superior_warrant: @officer)
    now = DateTime.current
    @posts = @officer.posts.where('start_date < ?', now)
                     .where('end_date > ? OR end_date IS NULL', now)
                     .approved
    @post_types = PostType.for_officer_page
  end
end
