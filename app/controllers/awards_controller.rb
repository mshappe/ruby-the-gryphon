class AwardsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :award_badges]

  load_and_authorize_resource except: [:award_badges]
  skip_authorization_check only: [:award_badges]

  downloads_files_for :award, :award_badge

  def index
    @q = @awards.ransack(query)
    @awards = @q.result.includes(:branch)
      .order('branches.name')
      .order(:precedence)
    @awards = restrict_by_branch(params[:branch]).page(params[:page])
  end

  def show
    @q = AwardRecipient.by_award(@award).ransack(query)
    @award_recipients = @q.result.page(page)
  end

  def new; end
  def edit; end

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
    return @awards if branch == 'all'
    branch ||= Branch.default_branch
    return @awards.where(branch: branch[:id])
  end

  def award_params
    params.require(:award).permit(:name, :description, :precedence, :award_badge,
                                  :award_type_id, :branch_id, :active)
  end

  def page
    params.permit(:page).fetch(:page, nil)
  end

  def query
    params.permit(q: [:court_event_name_cont, :persona_name_cont, :name_cont]).fetch(:q, nil)
  end

end
