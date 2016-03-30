class AddStatusToListings < ActiveRecord::Migration
  def change
    add_column :listings, :status, :string, default: "active"
  end
end
