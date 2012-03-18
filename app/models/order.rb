class Order < ActiveRecord::Base
  has_many :order_items, :dependent => :destroy
  accepts_nested_attributes_for :order_items, :allow_destroy => true
  after_create :notify_order_created
  after_destroy :notify_order_destroyed
  after_update :notify_order_updated
  before_save :update_total_price
  before_save :start_calculating
  before_save :synchronize_ready
  after_save :stop_calculating

  scope :pending, where(:ready => false)

  def self.calculating_order
    Thread.current[:calculating_order]
  end

  def self.calculating_order=(order)
    Thread.current[:calculating_order] = order
  end

  def initialize(*args)
    super
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
      updated_at.localtime.strftime("%H:%M")
    end
  end

  def paid?
    state == STATE_PAID
  end

  def serve_icon
    if use_placeholder?
      "%{order_serve_icon}"
    else
      served ? Css::Icon::SERVED : (ready ? Css::Icon::READY : Css::Icon::NEW)
    end
  end

  def payment_icon
    if use_placeholder?
      "%{order_payment_icon}"
    else
      paid ? Css::Icon::PAID : Css::Icon::UNPAID
    end
  end

  def theme
    if use_placeholder?
      "%{order_theme}"
    else
      ready ? Css::Theme::READY : Css::Theme::NEW
    end
  end

  [:served, :paid].each do |state|
    define_method :"mark_as_#{state}_visibility_style" do
      if use_placeholder?
        "%{order_mark_as_#{state}_visibility_style}"
      else
        self[state] ? Css::Style::HIDDEN : Css::Style::VISIBLE
      end
    end
  end

  def total_price
    if use_placeholder?
      "%{order_total_price}"
    else
      super
    end
  end

  def ready=(ready)
    if ready != self.ready
      super
      do_if_no_calculating_order do
        order_items.each do |order_item|
          if order_item.persisted?
            order_item.update_attribute(:ready, ready)
          else
            order_item.ready = ready
          end
        end
      end
      self.served = false unless ready
    end
  end

  def recalculate
    unless Order.calculating_order
      self[:ready] = recalculate_ready
      self.save
    end
  end

  def can_be_removed?
    persisted? && order_items.none?(&:ready)
  end

  private

  def start_calculating
    Order.calculating_order = self
  end

  def synchronize_ready
    self[:ready] = recalculate_ready
    nil
  end

  def stop_calculating
    Order.calculating_order = nil
  end

  def do_if_no_calculating_order
    begin
      start_calculating
      yield
    ensure
      stop_calculating
    end unless Order.calculating_order
  end

  def recalculate_ready
    order_items.reject(&:marked_for_destruction?).all?(&:ready)
  end

  def update_total_price
    self.total_price = order_items.reject(&:marked_for_destruction?).map(&:price).sum
  end

  def push_attributes
    {
      :order_id => order_id,
      :order_name => name,
      :order_ordered_time => ordered_time,
      :order_serve_icon => serve_icon,
      :order_payment_icon => payment_icon,
      :order_theme => theme,
      :order_mark_as_paid_visibility_style => mark_as_paid_visibility_style,
      :order_mark_as_served_visibility_style => mark_as_served_visibility_style,
      :order_total_price => total_price,
      :ready => ready
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

  def notify_order_updated
    attributes = push_attributes.merge(:updated => true)
    attributes.merge!(:order_items => order_items.reject(&:marked_for_destruction?).map(&:push_attributes)) if !ready && ready_changed?
    PubSub.publish(Order.channel, attributes)
  end
end
