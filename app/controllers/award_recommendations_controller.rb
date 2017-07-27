class AwardRecommendationsController < ApplicationController
  before_filter :get_award_recommendations, only: [:index]
  before_filter :get_awards, only: [:new, :create, :edit]

  load_and_authorize_resource

  def index; end
  def show; end
  def new; end

  def create
    if @award_recommendation.save
      flash[:notice] = 'Award recommendation sent!'
      AwardRecommendationNotifier.new_recommendation(@award_recommendation.id).deliver_later
    else
      flash[:error] = 'There was a problem submitting your recommendation!'
    end
    respond_with @award_recommendation
  end

  protected

  def award_recommendation_params
    params.require(:award_recommendation).permit(:award_id, :persona_id, :persona_name, :legal_name,
      :branch_id, :gender, :persona_description, :is_youth, :sca_term, :reason, :status,
      :planned_court_id, :submitted_by_person_id)
  end

  def get_award_recommendations
    @award_recommendations = AwardRecommendation.page(params[:page])
    if params[:hidden]
      @award_recommendations = @award_recommendations.where(status: AwardRecommendation::STATUS_HIDE)
      @title = 'Inactive Award Recommendations'
    else
      @award_recommendations = @award_recommendations.where(status: AwardRecommendation::STATUS_SHOW)
      @title = 'Active Award Recommendations'
    end
  end

  def get_awards
    @awards = AwardType.where.not(name: ['Royalty', 'Vigilant']).find_each.map do |at|
      [at.name, at.awards.where(branch: Branch.default_branch)
                          .where.not('name ILIKE ?', '%Cypher%')
                          .where.not('name ILIKE ?', '%Group Status%')
                          .where.not(name: 'Grant of Arms').order(:precedence)]
    end
  end
end
