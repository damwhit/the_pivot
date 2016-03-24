class RemoveSalePriceFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :sale_price, :integer
  end
end
