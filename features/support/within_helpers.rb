def within_waiting_list
  within "#orders" do
    yield
  end
end

def within_ordered_item name
  item = Item.find_by_name(name)
  within "#orders" do
    within "li[data-item-id='#{item.id}']" do
      yield
    end
  end
end
