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
      render "admin/categories/new"
    end
  end

  private

    def category_params
      params.require(:category).permit(:name)
    end
end
