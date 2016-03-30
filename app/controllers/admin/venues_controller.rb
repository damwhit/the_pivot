class Admin::VenuesController < Admin::BaseController
  def index
    @venues = Venue.all
  end
  def show
    @venue = Venue.find(params[:id])
  end
end
