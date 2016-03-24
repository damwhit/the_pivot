class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :price
      t.string :seat
      t.string :row
      t.references :listing, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
