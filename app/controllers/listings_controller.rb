class ListingsController < ApplicationController
  def new

  end

  def create
    redirect_to user_listings_path
  end

end
