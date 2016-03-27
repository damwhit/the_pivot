class AddStatusToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :status, :string, default: "active"
  end
end
