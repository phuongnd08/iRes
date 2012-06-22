require 'spec_helper'

describe Order do
  let(:order) { Order.new }
  let(:item1) { Item.make!(:price => 10000) }
  let(:item2) { Item.make!(:price => 25000) }
  let(:item3) { Item.make!(:price => 15000) }
  let(:item4) { Item.make!(:price => 20000) }

  describe "default" do
    it "is not ready" do
      order.ready.should == false
    end

    it "is not paid" do
      order.paid.should == false
    end

    it "is not served" do
      order.served.should == false
    end
  end

  describe "updating" do
    before do
      order.order_items_attributes = {
        1 => { :item_id => item1.id },
        2 => { :item_id => item2.id }
      }

      order.save
    end

    it "update nested order items information" do
      order.reload
      order.order_items.count.should == 2
      order.order_items[0].item.should == item1
      order.order_items[1].item.should == item2
    end

    it "notifys order is updated" do
      OrderItem.any_instance.stub(:notify_order_item_updated)
      PubSub.should_receive(:publish) do |channel, order_info|
        channel.should == Order.channel
        order_info[:order_id].should == order.id
        order_info[:updated].should be_true
        order_info[:ready].should be_true
      end
      order.update_attribute(:ready, true)
    end

    context "order is ready" do
      before do
        order.reload
        order.update_attribute(:ready, true)
      end

      context "when new items added" do
        before do
          order.order_items_attributes = {
            1 => { :item_id => item3.id },
            2 => { :item_id => item4.id }
          }
        end

        describe "notification" do
          it "includes order_items info" do
            OrderItem.any_instance.stub(:notify_order_item_created)
            PubSub.should_receive(:publish) do |channel, order_info|
              channel.should == Order.channel
              order_info[:order_id].should == order.id
              order_info[:order_items].should have(4).items
              order_info[:ready].should be_false
            end
            order.save
          end
        end

        it "does not affect ready state of existing item" do
          order.save
          order.order_items.map(&:ready).should == [true, true, false, false]
        end
      end
    end
  end

  describe "when created" do
    let(:order) { Order.new }
    before do
      order.order_items_attributes = {
        1 => { :item_id => item1.id },
        2 => { :item_id => item2.id }
      }
    end

    it "publish a message to order channel" do
      PubSub.should_receive(:publish) do |channel, order_info|
        channel.should == Order.channel
        order_info[:order_id].should == Order.last.id
        order_info[:name].should be_ends_with(order.table_number.to_s)
        order_info[:created].should be_true
      end
      OrderItem.any_instance.stub(:notify_order_item_created)
      order.save
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

  describe "marked as paid" do
    let!(:order) { Order.make!(:with_order_items) }
    it "marks all order items as paid" do
      order.update_attribute(:paid, true)
      order.order_items.all?(&:paid).should be_true
    end
  end
end
