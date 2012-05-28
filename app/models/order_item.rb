class OrderItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :order

  after_create :notify_order_item_created
  after_destroy :notify_order_item_destroyed
  after_update :notify_order_item_updated
  after_save :update_order

  def self.channel
    "/order_items"
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
    item.try(:name)
  end

  def order_item_id
    id
  end

  # Methods should already available from ActiveRecord. But for decoration to to work, we need to explicitly declare them
  delegate :id, :name, :to => :item, :prefix => true
  delegate :id, :to => :order, :prefix => true
  def price
    self[:price]
  end

  def theme
    ready ? Css::Theme::READY : Css::Theme::NEW
  end

  def ordered_time
      created_at.localtime.strftime("%H:%M")
  end

  def remove_visibility_class
    (ready || order.try(:paid)) ? Css::Class::HIDDEN : Css::Class::VISIBLE
  end

  def serve_icon
    ready ? Css::Icon::READY : Css::Icon::NEW
  end

  DECORATED_ATTRS = [
    :item_id, :item_name,
    :order_id, :order_item_id,
    :price,
    :theme,
    :ordered_time,
    :remove_visibility_class,
    :serve_icon
  ]

  DECORATED_ATTRS.each do |method|
    define_method :"#{method}_with_placeholder_awareness" do
      if use_placeholder?
        "%{#{method}}"
      else
        send(:"#{method}_without_placeholder_awareness")
      end
    end

    alias_method_chain method, :placeholder_awareness
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
