class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def add_listing(listing_id, quantity)
    contents[listing_id.to_s] ||= 0
    contents[listing_id.to_s] += quantity.to_i
  end

  def count
    contents.values.sum
  end

  def listings
    contents.map do |listing_id, quantity|
      CartListing.new(listing_id, quantity)
    end
  end

  def empty?
    contents.empty?
  end

  def remove_product_from_cart(id)
    contents.reject! {|k| k == id}
  end

  def update(params)
    contents[params[:id]] = params[:quantity].to_i
  end
end
