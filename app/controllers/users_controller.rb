# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string
#  last_name       :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  role            :integer          default(0)
#  fullname        :string
#  status          :string           default("active")
#

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def new_checkout
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:info] = "Hey #{@user.first_name}, welcome to ticketcacher."
      redirect_to root_path
    else
      flash.now[:alert] = "Sorry, friend.  Something went wrong :(... Please try again."
      render :new
    end
  end

  def show
    require_user
    @listings = current_user.listings.order(updated_at: :desc).take(3)
  end

private

  def user_params
    params.require(:user).permit(:fullname, :email, :password)
  end
end
