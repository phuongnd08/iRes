class Order < ActiveRecord::Base
  STATE_READY = "ready"
  STATE_NEW = "new"
  STATE_PAID = "paid"

  has_many :order_items, :dependent => :destroy
  accepts_nested_attributes_for :order_items, :allow_destroy => true
  after_create :notify_order_created
  after_destroy :notify_order_destroyed
  after_update :notify_if_state_changed

  scope :pending, where(:state => STATE_NEW)

  def initialize(*args)
    super
    self.state ||= STATE_NEW
  end

  def self.channel
    "/orders"
  end

  def order_id
    id || "%{order_id}"
  end

  def name
    if id
      "Order: #{I18n.t("order.table_no", :no => table_number)}"
    else
      "%{order_name}"
    end
  end

  def ordered_time
    if persisted?
      created_at.localtime.strftime("%H:%M")
    else
      "%{order_ordered_time}"
    end
  end

  def mark_ready_path
    if persisted?
      Rails.application.routes.url_helpers.mark_ready_order_path(self)
    else
      "%{order_mark_ready_path}"
    end
  end

  def ready?
    state == STATE_READY
  end

  def paid?
    state == STATE_PAID
  end

  private
  def notify_order_created
    PubSub.publish(Order.channel, {
      :order_id => order_id,
      :order_name => name,
      :order_ordered_time => ordered_time,
      :order_mark_ready_path => mark_ready_path,
      :created => true
    })
  end

  def notify_order_destroyed
    PubSub.publish(Order.channel, { :order_id => order_id, :deleted => true })
  end

  def notify_if_state_changed
    if state_changed?
      if ready?
        PubSub.publish(Order.channel, {
          :order_id => order_id,
          :changed => true,
          :ready => true
        })
      end
    end
  end
end
