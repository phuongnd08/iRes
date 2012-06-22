class Order < ActiveRecord::Base
  include Ajaxifier::Helpers
  include OrderStateMethods
  include Css::Class

  DATE_FORMAT = "%Y-%m-%d"
  TIME_FORMAT = "%H:%M"
  has_many :order_items, :dependent => :destroy
  accepts_nested_attributes_for :order_items, :allow_destroy => true
  before_save :update_total_price
  before_save :start_calculating
  before_save :synchronize_attributes
  after_create :notify_order_created
  after_destroy :notify_order_destroyed
  after_update :notify_order_updated
  after_save :stop_calculating

  scope :pending, where { (served != true) | (paid != true) }
  scope :paid, where { paid == true }
  scope :nonready, where { ready != true }
  scope :created_on, lambda { |date| where { (created_at >= date.to_time.beginning_of_day.utc) & (created_at <= date.to_time.end_of_day.utc) } }

  class << self
    def shown_to(role)
      if role.waiter?
        pending
      elsif role.manager?
        paid
      elsif role.chef?
        nonready
      end
    end

    def calculating_order
      Thread.current[:calculating_order]
    end

    def calculating_order=(order)
      Thread.current[:calculating_order] = order
    end
  end

  def initialize(*args)
    super
  end

  def self.channel
    "/orders"
  end

  def order_id
    id
  end

  def name
    "Order: #{I18n.t("order.table_no", :no => table_number)}"
  end

  def created_on
    created_at.localtime.strftime(Order::DATE_FORMAT)
  end

  def timing
    created_at.localtime.strftime(TIME_FORMAT).tap do |timing|
      timing << " (#{paid_at.localtime.strftime(TIME_FORMAT)})" if paid
    end
  end

  def completed
    paid && served
  end

  def modifiable
    !paid
  end

  def total_price
    self[:total_price]
  end

  DECORATED_ATTRS = [
    :order_id, :name,
    :theme, :total_price,
    :timing,
    :ready_icon_visibility_class, :served_icon_visibility_class, :paid_icon_visibility_class,
    :mark_as_served_visibility_class, :mark_as_paid_visibility_class
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

  def revenue_increment
    if paid && paid_changed?
      total_price
    else
      0
    end
  end

  private

  # before save callbacks, must never return false
  def synchronize_attributes
    self[:ready] = recalculate_ready
    self.served = false unless ready
    self.paid_at = Time.now if paid && paid_changed?
    nil
  end

  def start_calculating
    Order.calculating_order = self
  end

  def update_total_price
    self.total_price = order_items.reject(&:marked_for_destruction?).map(&:price).sum
  end

  # helper

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

  BASIC_ATTRS = [
    :order_id, :created_on
  ]

  def keys_to_push_attributes(keys)
    keys.inject({}) do |hash, key|
      hash[key] = send(key)
      hash
    end
  end

  def basic_push_attributes
    keys_to_push_attributes(BASIC_ATTRS)
  end

  def shown_to
    {
      :waiter => !(paid && served),
      :manager => paid,
      :chef => !ready
    }
  end

  FULL_ATTRS = BASIC_ATTRS + DECORATED_ATTRS + [
    :total_price, :revenue_increment,
    :shown_to,
    :completed, :ready, :paid
  ]

  def full_push_attributes
    keys_to_push_attributes(FULL_ATTRS).merge!(:order_items => order_items.map(&:push_attributes))
  end

  def notify_order_created
    PubSub.publish(Order.channel, full_push_attributes.merge(:created => true))
  end

  def notify_order_destroyed
    PubSub.publish(Order.channel, basic_push_attributes.merge(:deleted => true))
  end

  def notify_order_updated
    attributes = full_push_attributes.merge(:updated => true)
    attributes.merge!(:order_items => order_items.reject(&:marked_for_destruction?).map(&:push_attributes)) if !ready && ready_changed?
    PubSub.publish(Order.channel, attributes)
  end
end
