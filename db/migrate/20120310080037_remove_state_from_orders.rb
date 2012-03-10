class RemoveStateFromOrders < ActiveRecord::Migration
  def up
    remove_column :orders, :state
  end

  def down
    add_column :orders, :state, :string
  end
end
