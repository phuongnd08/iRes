class Order < ActiveRecord::Base
  has_many :order_items, :dependent => :destroy
  accepts_nested_attributes_for :order_items, :allow_destroy => true
  after_create :notify_new_order

  def self.pending
    all
  end

  def self.channel
    "/orders"
  end

  private
  def notify_new_order
    PubSub.publish(Order.channel, { :id => id, :table_number => table_number })
  end
end
