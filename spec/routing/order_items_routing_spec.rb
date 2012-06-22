require "spec_helper"

describe OrderItemsController do
  describe "routing" do

    it "routes to #change_state" do
      put("/order_items/1/change_state").should route_to("order_items#change_state", :id => "1")
    end

  end
end
