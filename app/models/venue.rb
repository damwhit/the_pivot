# == Schema Information
#
# Table name: venues
#
#  id    :integer          not null, primary key
#  name  :string
#  city  :string
#  state :string
#

class Venue < ActiveRecord::Base
  has_many :events
end
