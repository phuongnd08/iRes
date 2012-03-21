describe HomeController do
  it "routes to #waiter" do
    get("/waiter").should route_to("home#waiter")
  end

  it "routes to #chef" do
    get("/chef").should route_to("home#chef")
  end

  it "routes to #manager" do
    get("/manager").should route_to('home#manager')
  end
end
