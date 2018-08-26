# frozen_string_literal: true

class Manage::ManagementController < ApplicationController
  layout 'management'
  before_filter :authenticate_user!
  before_filter :user_is_admin?

  def user_is_admin?
    raise CanCan::AccessDenied unless current_user.has_role? :admin
  end
end
