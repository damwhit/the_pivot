class Admin::CategoriesController < Admin::BaseController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:info] = "Created category: #{@category.name}"
      redirect_to admin_categories_path
    else
      flash.now[:error] = "Sorry, could not create that new category."
      render :new
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:info] = "Updated category: #{@category.name}"
      redirect_to admin_categories_path
    else
      flash.now[:error] = "sorry, unable to update category"
      @categories = Category.all
      render :index
    end
  end

  private

    def category_params
      params.require(:category).permit(:name)
    end
end
