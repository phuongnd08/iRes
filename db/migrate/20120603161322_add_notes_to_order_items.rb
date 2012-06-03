class AddNotesToOrderItems < ActiveRecord::Migration
  def change
    add_column :order_items, :notes, :string

  end
end
