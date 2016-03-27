class CartListing < SimpleDelegator
attr_reader :listing, :quantity

  def initialize(listing_id, quantity)
    @listing = Listing.find(listing_id)
    @quantity = quantity
    super(@listing)
  end

  def subtotal
    listing.price * quantity
  end

  def format_subtotal
    subtotal / 100
  end
end
