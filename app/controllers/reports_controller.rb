# frozen_string_literal: true

class ReportsController < ApplicationController
  load_and_authorize_resource

  def new
    
  end

  protected

  def report_params
    params.require(:report).permit(:post_type_id, :persona_id, :warrant_type_id, :title, :body, :url, :start_date, 
                                   :end_date, :approved, body_fields: [])
  end
end
