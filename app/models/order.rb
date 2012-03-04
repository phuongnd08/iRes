class Order < ActiveRecord::Base
  has_many :order_items, :dependent => :destroy
  accepts_nested_attributes_for :order_items, :allow_destroy => true
  after_create :notify_order_created
  after_destroy :notify_order_destroyed

  def self.pending
    all
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

  private
  def notify_order_created
    PubSub.publish(Order.channel, { :order_id => order_id, :order_name => name, :order_ordered_time => ordered_time })
  end

  def notify_order_destroyed
    PubSub.publish(Order.channel, { :order_id => order_id, :deleted => true })
  end
end
