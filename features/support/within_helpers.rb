def within_waiting_list
  within "#chef_orders_page" do
    yield
  end
end
