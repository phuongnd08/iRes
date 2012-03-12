class AddReadyToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :ready, :boolean, :default => false

  end
end
