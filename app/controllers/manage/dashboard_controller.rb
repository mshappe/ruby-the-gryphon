# frozen_string_literal: true

class Manage::DashboardController < Manage::ManagementController
  before_filter :get_managables

  protected

  def get_managables
    @user_q = User.ransack(params[:user_q])
    @users = @user_q.result.order(email: :asc).page(params[:user_page]).per(10)
    @roles = Role.all
    @reign_q = Reign.ransack(params[:reign_q])
    @reigns = @reign_q.result.order(id: :desc).page(params[:reign_page]).per(10)
    @report_q = Report.ransack(params[:report_q])
    @reports = @report_q.result.order(id: :desc).page(params[:report_page]).per(10)
    authorize! :manage, @users
  end
end
