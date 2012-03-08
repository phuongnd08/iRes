class AddTotalPriceToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :total_price, :integer, :default => 0

  end
end
