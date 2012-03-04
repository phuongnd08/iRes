require 'spec_helper'

describe Order do
  let(:order) { Order.new }
  let(:item1) { Item.make! }
  let(:item2) { Item.make! }

  describe "updating" do
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
  end

  describe "when created" do
    it "publish a message to order channel" do
      PubSub.should_receive(:publish) do |channel, order_info|
        channel.should == Order.channel
        order_info[:order_id].should == Order.last.id
        order_info[:order_name].should be_ends_with(order.table_number.to_s)
      end
      order = Order.create
    end
  end

  describe "when destroyed" do
    let!(:order) { Order.make! }
    it "publish a deleted message to order channel" do
      PubSub.should_receive(:publish) do |channel, order_info|
        channel.should == Order.channel
        order_info[:order_id].should == order.id
        order_info[:deleted].should be_true
      end
      order.destroy
    end
  end
end
