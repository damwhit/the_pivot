class DropOrderTicketsTable < ActiveRecord::Migration
  def change
    drop_table :order_tickets
  end
end
