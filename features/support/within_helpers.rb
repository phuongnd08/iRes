def within_waiting_list
  within "#orders" do
    yield
  end
end
