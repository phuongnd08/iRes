class OrderItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :order

  delegate :id, :name, :to => :item, :prefix => true
  delegate :id, :to => :order, :prefix => true

  after_create :notify_order_item_created
  after_destroy :notify_order_item_destroyed

  def item_id
    super || "%{item_id}"
  end

  def item=(*arg)
    super
    copy_price_from_item
  end

  def item_id=(*arg)
    super
    copy_price_from_item
  end

  def item_name
    item.try(:name) || "%{item_name}"
  end

  def order_id
    order.try(:id) || "%{order_id}"
  end

  def order_item_id
    id || "%{order_item_id}"
  end

  def self.channel
    "/order_items"
  end

  def price
    super || "%{order_item_price}"
  end

  private
  def copy_price_from_item
    self.price = item.try(:price)
  end

  def notify_order_item_created
    PubSub.publish(OrderItem.channel, {
      :order_item_id => order_item_id,
      :order_id => order_id,
      :item_id => item_id,
      :item_name => item_name
    })
  end

  def notify_order_item_destroyed
    PubSub.publish(OrderItem.channel, {
      :order_item_id => order_item_id,
      :deleted => true
    })
  end
end
