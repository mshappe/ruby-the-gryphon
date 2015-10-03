class AwardsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :award_badges]

  load_and_authorize_resource except: [:award_badges]
  skip_authorization_check only: [:award_badges]

  downloads_files_for :award, :award_badge

  def index
    ap params[:branch]
    @awards = @awards.includes(:branch)
    @awards = @awards.order('branches.name').order(:precedence) # Default to precedence order if no parameters given to the contrary
    @awards = restrict_by_branch params[:branch]
  end

  protected

  def restrict_by_branch(branch)
    return @awards.where(branch: Branch.default_branch) if branch.nil?
    return @awards.where(branches: { id: branch[:id] }) if branch.is_a?(Hash) && branch.has_key?(:id)
    @awards
  end

end