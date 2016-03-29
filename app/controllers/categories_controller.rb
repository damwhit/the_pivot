# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CategoriesController < ApplicationController
  def show
    @category = Category.find_by(name: params[:name])
  end
end
