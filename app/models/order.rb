class Order < ActiveRecord::Base
  STATE_READY = "ready"
  STATE_NEW = "new"
  STATE_PAID = "paid"

  has_many :order_items, :dependent => :destroy
  accepts_nested_attributes_for :order_items, :allow_destroy => true
  after_create :notify_order_created
  after_destroy :notify_order_destroyed
  after_update :notify_changed
  before_save :update_total_price

  scope :pending, where(:state => STATE_NEW)

  def initialize(*args)
    super
    self.state ||= STATE_NEW
  end

  def self.channel
    "/orders"
  end

  def order_id
    if use_placeholder?
      "%{order_id}"
    else
      id
    end
  end

  def name
    if use_placeholder?
      "%{order_name}"
    else
      "Order: #{I18n.t("order.table_no", :no => table_number)}"
    end
  end

  def ordered_time
    if use_placeholder?
      "%{order_ordered_time}"
    else
      created_at.localtime.strftime("%H:%M")
    end
  end

  def ready?
    state == STATE_READY
  end

  def paid?
    state == STATE_PAID
  end

  def icon
    if use_placeholder?
      "%{order_icon}"
    else
      ready? ? 'star' : 'arrow-r'
    end
  end

  def theme
    if use_placeholder?
      "%{order_theme}"
    else
      ready? ? 'e' : 'c'
    end
  end

  def total_price
    if use_placeholder?
      "%{order_total_price}"
    else
      super
    end
  end

  def to_param
    if use_placeholder?
      "%{order_id}"
    else
      super
    end
  end

  private

  def update_total_price
    self.total_price = order_items.reject(&:marked_for_destruction?).map(&:price).sum
  end

  def push_attributes
    {
      :order_id => order_id,
      :order_name => name,
      :order_ordered_time => ordered_time,
      :order_icon => icon,
      :order_theme => theme,
      :order_total_price => total_price
    }
  end

  def notify_order_created
    PubSub.publish(Order.channel, push_attributes.merge({
      :created => true
    }))
  end

  def notify_order_destroyed
    PubSub.publish(Order.channel, { :order_id => order_id, :deleted => true })
  end

  def notify_changed
    PubSub.publish(Order.channel, push_attributes.merge({
      :changed => true,
      :ready => ready?
    }))
  end
end
