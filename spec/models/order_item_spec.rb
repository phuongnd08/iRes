require 'spec_helper'

describe OrderItem do
  describe "creation" do
    let!(:order) { Order.make! }
    let(:item) { Item.make!(:name => "Coffee") }
    it "publish a message to order_items channel" do
      PubSub.should_receive(:publish) do |channel, order_item_info|
        order_item_info[:order_item_id].to_i.should == OrderItem.last.id
        order_item_info[:order_id].should == order.id
        order_item_info[:item_name].should == item.name
      end

      OrderItem.create(:order => order, :item => item)
    end
  end

  describe "deletion" do
    let(:order) { Order.make! }
    let(:item) { Item.make!(:name => "Coffee") }
    let!(:order_item) { OrderItem.create(:order => order, :item => item) }
    it "publish a message to order_items channel" do
      PubSub.should_receive(:publish) do |channel, order_item_info|
        order_item_info[:order_item_id].to_i.should == order_item.id
        order_item_info[:deleted].should be_true
      end

      order_item.destroy
    end

  end
end
