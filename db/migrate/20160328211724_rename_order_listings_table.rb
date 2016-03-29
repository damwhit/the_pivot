class RenameOrderListingsTable < ActiveRecord::Migration
  def change
    rename_table :order_listings, :order_tickets
  end
end
