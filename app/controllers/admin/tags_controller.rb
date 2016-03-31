class Admin::TagsController < Admin::BaseController
  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end

  def show
    @tag = Tag.find(params[:id])
    @events = @tag.events
    @venues = @tag.venues
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      flash[:info] = "created new tag: #{@tag.name}!!!"
      redirect_to admin_tags_path
    else
      flash.now[:error] = "couldn't create tag... try again!!!"
      render :new
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end
