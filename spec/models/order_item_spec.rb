require 'spec_helper'

describe OrderItem do
  describe "creation" do
    let(:order) { Order.make! }
    let(:item) { Item.make!(:name => "Coffee") }
    it "publish a message to order_items channel" do
      PubSub.should_receive(:publish) do |channel, order_item_info|
        order_item_info[:order_id].should == order.id
        order_item_info[:item_name].should == item.name
      end

      OrderItem.create(:order => order, :item => item)
    end
  end
end
