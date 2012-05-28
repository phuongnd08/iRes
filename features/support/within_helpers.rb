def within_waiting_list
  within "#orders_page" do
    yield
  end
end
