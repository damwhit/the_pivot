class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_cart
  helper_method :current_user, :current_admin?

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def active_user?
    current_user.status == "active"
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def require_user
    redirect_to root_path unless current_user
  end
end
