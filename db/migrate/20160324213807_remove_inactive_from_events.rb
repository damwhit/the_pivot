class RemoveInactiveFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :inactive, :boolean
  end
end
