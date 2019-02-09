class WarrantsController < ApplicationController
  load_and_authorize_resource

  before_action :get_form_data, only: [:new, :edit]
  before_action :get_new_warrant, only: :new
  before_action :get_queued_warrants, only: :queued
  before_action :get_warrants, only: :index

  def index
  end

  def queued
    ap current_user
  end

  def show
  end

  def new
  end

  def create
  end

  private

  def get_form_data
    @office_scope = [
      ['Kingdom, Regional, or At Large Office', 'kingdom' ],
      ['Local Branch Office', 'branch']
   ].freeze
  end

  def get_new_warrant
    @warrant = Warrant.new(person: current_user&.person, submission_state: 'queued')
  end

  def get_warrants
    superior_warrants = current_user.warrants.current.pluck(:warrant_type_id)
    @subordinates = WarrantType.where(superior_warrant_id: superior_warrants)
    @warrants = Warrant.where(warrant_type: @subordinates).current
  end

  def get_queued_warrants
    ap current_user.warrants
    superior_warrants = current_user.warrants.current.pluck(:warrant_type_id)
    @subordinates = WarrantType.where(superior_warrant_id: superior_warrants)
    @warrants = Warrant.where(warrant_type: @subordinates).queued
    authorize! :queued, Warrant
  end

  def warrant_params
    params.require(:warrant).permit(:branch_id, :person_id, :warrant_type_id,
                                    :tenure_start, :tenure_end, :approved_date,
                                    :introduction, :comments,
                                    :submission_state)
  end
end