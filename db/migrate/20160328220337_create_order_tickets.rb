class CreateOrderTickets < ActiveRecord::Migration
  def change
    create_table :order_tickets do |t|
      t.references :order, index: true, foreign_key: true
      t.references :ticket, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
