class ChangeSubmittedByUserToSubmittedByPersonInAwardRecommendation < ActiveRecord::Migration
  def change
    add_column :award_recommendations, :submitted_by_person_id, :integer, index: true
    remove_column :award_recommendations, :submitted_by_user_id, :integer, index: true
  end
end
