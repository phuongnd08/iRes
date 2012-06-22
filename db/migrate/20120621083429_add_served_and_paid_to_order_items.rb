class AddServedAndPaidToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :served, :boolean
    add_column :order_items, :paid, :boolean
  end
end
