class RemovePriceFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :price, :string
  end
end
