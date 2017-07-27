class AwardRecommendationNotifier < ApplicationMailer
  def new_recommendation(award_recommendation_id)
    @rec = AwardRecommendation.find(award_recommendation_id)
    @submitter = @rec.submitted_by_person
    mail subject: "New Award Rec: #{@rec.award.name} for #{@rec.persona_name}",
          to: User.with_any_role(:royalty, :award_manager).collect(&:email)
  end
end
