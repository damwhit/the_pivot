class Admin::EventsController < Admin::BaseController
  def index
    flash.now[:info] = "This is the flash for events"
  end
end
