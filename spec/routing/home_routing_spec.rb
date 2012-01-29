describe HomeController do
  it "routes to #waiter" do
    get("/waiter").should route_to("home#waiter")
  end
end
