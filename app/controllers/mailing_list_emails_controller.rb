# == Schema Information
#
# Table name: mailing_list_emails
#
#  id    :integer          not null, primary key
#  email :string
#

class MailingListEmailsController < ApplicationController
  def create
    @email = MailingListEmail.new(mailing_list_email_params)
    if @email.save
      flash[:info] = "Hey, thx for joining :)"
      redirect_to root_path
    else
      flash[:alert] = "Sorry, friend.  Something went wrong :(... Please try again."
      redirect_to root_path
    end
  end

  private

  def mailing_list_email_params
    params.permit(:email)
  end
end
