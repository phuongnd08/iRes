class OrderItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :order

  delegate :id, :name, :to => :item, :prefix => true
  delegate :id, :to => :order, :prefix => true

  after_create :notify_order_item_created
  after_destroy :notify_order_item_destroyed
  after_update :notify_order_item_updated
  after_save :update_order

  def self.channel
    "/order_items"
  end

  def item_id
    if use_placeholder?
      "%{item_id}"
    else
      super
    end
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
    if use_placeholder?
      "%{item_name}"
    else
      item.try(:name)
    end
  end

  def order_id
    if use_placeholder?
      "%{order_id}"
    else
      order.try(:id)
    end
  end

  def order_item_id
    if use_placeholder?
      "%{order_item_id}"
    else
      id
    end
  end

  def price
    if use_placeholder?
      "%{order_item_price}"
    else
      super
    end
  end


  def theme
    if use_placeholder?
      "%{theme}"
    else
      ready ? Css::Theme::READY : Css::Theme::NEW
    end
  end

  def ordered_time
    if use_placeholder?
      "%{ordered_time}"
    else
      created_at.localtime.strftime("%H:%M")
    end
  end

  def remove_visibility_style
    if use_placeholder?
      "%{order_item_remove_visibility_style}"
    else
      (ready || order.try(:paid)) ? Css::Style::HIDDEN : Css::Style::VISIBLE
    end
  end

  def serve_icon
    if use_placeholder?
      "%{serve_icon}"
    else
      ready ? Css::Icon::READY : Css::Icon::NEW
    end
  end

  def push_attributes
    {
      :order_item_id => order_item_id,
      :order_id => order_id,
      :item_id => item_id,
      :item_name => item_name,
      :theme => theme,
      :serve_icon => serve_icon,
      :ordered_time => ordered_time
    }
  end

  private
  def copy_price_from_item
    self.price = item.try(:price)
  end

  def notify_order_item_created
    PubSub.publish(OrderItem.channel, push_attributes.merge(:created => true))
  end

  def notify_order_item_updated
    PubSub.publish(OrderItem.channel, push_attributes.merge(:updated => true))
  end

  def notify_order_item_destroyed
    PubSub.publish(OrderItem.channel, {
      :order_item_id => order_item_id,
      :deleted => true
    })
  end

  def update_order
    order.recalculate
  end
end
