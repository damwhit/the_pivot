# == Schema Information
#
# Table name: orders
#
#  id          :integer          not null, primary key
#  street      :string
#  unit        :string
#  city        :string
#  state       :string
#  zip         :string
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  first_name  :string
#  last_name   :string
#  email       :string
#  status      :string           default("paid")
#  fullname    :string
#  card_token  :string
#  order_total :integer
#

class OrdersController < ApplicationController
  before_action :require_user, only: [:show, :thanks, :index]

  def new
    if active_user?
      @tickets = OrderProcessor.new(@cart).tickets
      @order = Order.new
      render :new
    else
      flash[:info] = "sorry, you cannot purchase tickets :("
      @cart.empty_cart
      session[:cart] = @cart.contents
      redirect_to root_path
    end
  end


  def checkout_user
    login_or_create_user
    redirect_to checkout_path
  end

  def create
    order_processor = OrderProcessor.new(@cart)
    @order = order_processor.process_current_user(stripe_params, current_user)
    if @order.save
      @order.process(order_processor.tickets)
      @order.set_ticket_status
      # OrderMailer.order_email(@order).deliver_now
      flash[:info] = "Thanks for your order! :)"
      session[:cart] = nil
      redirect_to user_thanks_path(current_user, @order.id)
    else
      flash.now[:alert] = "Sorry, friend.  Something went wrong :(... Please try again."
      render :new
    end
  end

  def show
    @order = current_user.orders.find(params[:id])
    @order_tickets = @order.sort_tickets
  end

  def thanks
    @order = current_user.orders.find(params[:order_id])
  end

  def index
    @orders = current_user.orders
  end

  def login_or_create_user
    @user = User.find_by(email: params[:email])
    @user = User.new(user_params) if @user.nil?
    if @user.save
      current_user
      session[:user_id] = @user.id
    else
      flash.now[:alert] = "Sorry, friend.  Something went wrong :(... Please try again."
      render :checkout_login
    end
  end

  def checkout_login
  end

  private

  def user_params
    params.permit(:fullname, :email, :password)
  end

  def stripe_params
    params.permit(:stripeEmail, :stripeToken, :stripeShippingName, :stripeShippingAddressLine1, :stripeShippingAddressCity, :stripeShippingAddressZip, :stripeShippingAddressState, :stripeShippingAddressZip )
  end
end
