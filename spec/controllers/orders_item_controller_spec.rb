require 'spec_helper'

describe OrderItemsController do
  describe "PUT change_state" do
    let(:order_item) { OrderItem.make!  }
    [:ready, :served, :paid].each do |state|
      it "change the order item #{state} to true" do
        order_item.send(state.to_sym).should be_false
        put :change_state, :id => order_item.id, :state => state
        order_item.reload.send(state.to_sym).should be_true
      end
    end
  end
end
