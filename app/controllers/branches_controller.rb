# frozen_string_literal: true

class BranchesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show branch_heraldries map_images]

  load_and_authorize_resource except: %i[branch_heraldries map_images]
  skip_authorization_check only: %i[branch_heraldries map_images]
  downloads_files_for :branch, :branch_heraldry
  downloads_files_for :branch, :map_image

  before_action :get_branches, only: [:index]
  before_action :get_events, only: [:show]

  def index; end
  def show; end

  protected

  def get_branches
    @branches = Branch.active.where(parent_branch: Branch.default_branch)
    @subsidiaries = Branch.active.where(parent_branch: @branches)
    @branches = (@branches + @subsidiaries).flatten.compact.uniq
    @branches_by_state = @branches.group_by { |b| b.state }
  end

  def get_events
    @events = Event.where('branch_id = ? or sponsor_branch_id = ?', params[:id], params[:id]).next_three_months
  end
end
