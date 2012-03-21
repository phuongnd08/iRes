class AddServedToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :served, :boolean, :default => false
  end
end
