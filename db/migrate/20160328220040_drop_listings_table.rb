class DropListingsTable < ActiveRecord::Migration
  def change
    drop_table :order_tickets
  end
end
