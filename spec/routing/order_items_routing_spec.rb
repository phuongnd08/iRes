require "spec_helper"

describe OrderItemsController do
  describe "routing" do

    it "routes to #mark_ready" do
      put("/order_items/1/mark_ready").should route_to("order_items#mark_ready", :id => "1")
    end

  end
end
