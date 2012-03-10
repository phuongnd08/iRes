require 'spec_helper'

describe Order do
  let(:order) { Order.new }
  let(:item1) { Item.make!(:price => 10000) }
  let(:item2) { Item.make!(:price => 25000) }

  describe "default" do
    it "is not ready" do
      order.ready.should be_false
    end
  end

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

    context "updated" do
      it "notifys order is updated" do
        order.save
        OrderItem.any_instance.stub(:notify_order_item_updated)
        PubSub.should_receive(:publish) do |channel, order_info|
          channel.should == Order.channel
          order_info[:order_id].should == order.id
          order_info[:updated].should be_true
          order_info[:ready].should be_true
        end
        order.update_attribute(:ready, true)
      end
    end
  end

  describe "when created" do
    it "publish a message to order channel" do
      PubSub.should_receive(:publish) do |channel, order_info|
        channel.should == Order.channel
        order_info[:order_id].should == Order.last.id
        order_info[:order_name].should be_ends_with(order.table_number.to_s)
        order_info[:created].should be_true
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

  describe "#total_price" do
    before do
      order.order_items << OrderItem.new(:item => item1)
      order.order_items << OrderItem.new(:item => item2)
      order.save
    end

    it "is kept in sync with order items" do
      order.total_price.should == 35000
    end

    it "is keep insync when update with nested attributes" do
      order.update_attributes(:order_items_attributes => { "0" => { :_destroy => 1, :id => order.order_items.first.id } })
      order.total_price.should == 25000
    end
  end
end
