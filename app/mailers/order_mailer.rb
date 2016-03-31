class OrderMailer < ApplicationMailer
  def order_email(order)
    @order = order
    @url = "http://ticketcacher.herokuapp.com"
    mail(to: @order.email, subject: '🎉Here is your ticket!🎉')
  end
end
