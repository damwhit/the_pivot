class Admin::VenuesController < Admin::BaseController
  def index
    @venues = Venue.all
  end

  def show
    @venue = Venue.find(params[:id])
  end

  def update
    @venue = Venue.find(params[:id])
    save_valid_tags
    redirect_to admin_venues_path
  end

  private
    def save_valid_tags
      @venue.tags.clear
      Tag.valid_tags(params[:tags]).each do |tag|
        @venue.tags << tag
      end
      @venue.save
    end

end
