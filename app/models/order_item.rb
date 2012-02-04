class OrderItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :order

  delegate :id, :name, :to => :item, :prefix => true
  delegate :id, :to => :order, :prefix => true

  after_create :notify_new_order_item


  def self.channel
    "/order_items"
  end

  private
  def notify_new_order_item
    PubSub.publish(OrderItem.channel, { :order_id => order_id, :item_id => item_id, :item_name => item_name })
  end
end
