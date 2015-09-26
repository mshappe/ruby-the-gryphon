class AwardsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :award_badges]

  load_and_authorize_resource except: [:award_badges]
  skip_authorization_check only: [:award_badges]

  downloads_files_for :award, :award_badge

  def index
    @awards = @awards.includes(:branch)
    @awards = @awards.order(:precedence) # Default to precedence order if no parameters given to the contrary
  end

end