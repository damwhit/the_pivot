class RemoveSaleFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :sale, :boolean
  end
end
