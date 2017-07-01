class Manage::DashboardController < Manage::ManagementController
  before_filter :get_managables

  def index
  end

  protected

  def get_managables
    @user_q = User.ransack(params[:user_q])
    @users = @user_q.result.order(email: :asc).page(params[:user_page])
    authorize! :manage, @users
  end
end
