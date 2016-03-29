# == Schema Information
#
# Table name: mailing_list_emails
#
#  id    :integer          not null, primary key
#  email :string
#

class MailingListEmail < ActiveRecord::Base
  validates :email, presence: true
end
