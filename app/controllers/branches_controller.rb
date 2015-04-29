class BranchesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :branch_heraldries, :map_images]
  load_and_authorize_resource except: [:branch_heraldries, :map_images]
  downloads_files_for :branch, :branch_heraldry
  downloads_files_for :branch, :map_image

  before_action :get_events, only: [:show]

  protected

  def get_events
    @events = Event.where('branch_id = ? or sponsor_branch_id = ?', params[:id], params[:id]).next_three_months
  end

end
