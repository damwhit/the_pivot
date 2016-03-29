# == Schema Information
#
# Table name: events
#
#  id                 :integer          not null, primary key
#  name               :string
#  category_id        :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  time               :datetime
#  status             :string           default("upcoming")
#  venue_id           :integer
#

class EventsController < ApplicationController

  def index
    require_user
    @events = Event.upcoming_events.paginate(page:
                                             params[:page]).order(time:
                                                                  :asc)
  end

  def show
    @event = Event.find(params[:id])
  end
end
