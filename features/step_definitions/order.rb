def create_order_items(order, item_hashes)
  item_hashes.each do |hash|
    category = Category.find_by_name(hash['category'])
    raise "Category #{hash['category']} not found" unless category
    item = Item.find_by_category_id_and_name(category.id, hash['name'])
    order.order_items << OrderItem.new(:item => item)
  end
end

Given /^(?:these items are|this item is) ordered:$/ do |table|
  create_order_items(Order.create, table.hashes)
end

Given /^an order of table (\d+) is committed with these items:$/ do |number, table|
  create_order_items(Order.create(:table_number => number.to_i), table.hashes)
end

