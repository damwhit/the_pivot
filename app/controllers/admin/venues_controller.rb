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

  def remove_tag
    venue = Venue.find(params[:id])
    tag = venue.tags.find(params[:tag_id])
    if tag
      venue.tags.delete(tag)
      flash[:info] = "Removed #{tag.name} from #{venue.name}"
      redirect_to admin_tag_path(tag.id)
    end
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
