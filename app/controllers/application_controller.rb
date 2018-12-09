# frozen_string_literal: true

require 'application_responder'

class ApplicationController < ActionController::Base
  include Paperclip::Storage::Database::ControllerClassMethods
  check_authorization

  self.responder = ApplicationResponder
  respond_to :html

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    if current_user
      flash[:alert] = "Access denied! #{exception.message}"
    else
      flash[:alert] = 'Please sign in to make this request!'
    end
    redirect_to root_url
  end
end
