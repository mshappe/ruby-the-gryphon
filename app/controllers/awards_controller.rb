class AwardsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :award_badges]

  load_and_authorize_resource except: [:award_badges]
  skip_authorization_check only: [:award_badges]

  downloads_files_for :award, :award_badge

  def index
    @q = @awards.ransack(params[:q])
    @awards = @q.result.includes(:branch)
      .order('branches.name')
      .order(:precedence)
      .page(params[:page])
    @awards = restrict_by_branch(params[:branch])
  end

  def show
    @q = AwardRecipient.by_award(@award).ransack(params[:q])
    @award_recipients = @q.result.page(params[:page])
  end

  def create
    flash[:error] = 'Your submission had errors.' unless @award.save
    respond_with @award
  end

  def update
    flash[:error] = 'Your submission had errors.' unless @award.update_attributes award_params
    respond_with @award
  end

  protected

  def restrict_by_branch(branch)
    return @awards.where(branch: Branch.default_branch) if branch.nil?
    return @awards.where(branches: { id: branch[:id] }) if branch.is_a?(Hash) && branch.has_key?(:id)
    @awards
  end

  def award_params
    params.require(:award).permit!
  end

end
