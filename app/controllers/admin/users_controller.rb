class Admin::UsersController < Admin::BaseController
  def index
    @users = User.where(status: "active")
  end
end
