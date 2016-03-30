class AddOrderIdToTickets < ActiveRecord::Migration
  def change
    add_reference :tickets, :order, index: true, foreign_key: true
  end
end
