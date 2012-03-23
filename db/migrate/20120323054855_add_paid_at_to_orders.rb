class AddPaidAtToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :paid_at, :datetime
    Order.reset_column_information
    Order.paid.update_all(:paid_at => Time.now)
  end

  def self.down
    remove_column :orders, :paid_at
  end
end
