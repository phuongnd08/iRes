require 'spec_helper'

describe Order do
  let(:order) { Order.new }
  let(:item1) { Item.make! }
  let(:item2) { Item.make! }

  before(:each) do
    counter = Time.now.to_i
    order.order_items_attributes = {
      counter => { :item_id => item1.id },
      (counter + 1) => { :item_id => item2.id }
    }

    order.save
  end

  it "update nested order items information" do
    order.reload
    order.order_items.count.should == 2
    order.order_items[0].item.should == item1
    order.order_items[1].item.should == item2
  end

  describe "when created" do
    it "publish a message to order channel" do
      PubSub.should_receive(:publish) do |channel, order_info|
        channel.should == Order.channel
        order_info[:id].should_not be_nil
        order_info[:table_number].should == order.table_number
      end
      order = Order.create
    end
  end
end
