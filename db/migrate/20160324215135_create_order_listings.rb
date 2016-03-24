class CreateOrderListings < ActiveRecord::Migration
  def change
    create_table :order_listings do |t|
      t.references :listing, index: true, foreign_key: true
      t.references :order, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
