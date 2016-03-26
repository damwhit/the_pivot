class Admin::UsersController < Admin::BaseController
  def index
    @users = User.filter_by_status(params[:status])
  end
end
