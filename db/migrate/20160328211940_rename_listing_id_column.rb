class RenameListingIdColumn < ActiveRecord::Migration
  def change
    rename_column :order_tickets, :listing_id, :ticket_id
  end
end
