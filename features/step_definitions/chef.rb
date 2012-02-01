Given /^these items is ordered:$/ do |table|
  order = Order.create
  table.hashes.each do |hash|
    category = Category.find_by_name(hash['category'])
    item = Item.find_by_category_id_and_name(category.id, hash['name'])
    order.order_items << OrderItem.create!(:item => item)
  end
end

When /^I'm on chef page$/ do
  visit "/chef"
end
