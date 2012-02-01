Given /^(?:these items are|this item is) ordered:$/ do |table|
  order = Order.create
  table.hashes.each do |hash|
    category = Category.find_by_name(hash['category'])
    item = Item.find_by_category_id_and_name(category.id, hash['name'])
    order.order_items << OrderItem.new(:item => item)
  end
end

When /^I'm on chef page$/ do
  visit "/chef"
end

Then /^I see (\d+) items being listed$/ do |count|
  within "#ordered_items" do
    page.all("li").count.should == count.to_i
  end
end

Then /^I see "([^"]*)" in the ordered list$/ do |item_name|
  within "#ordered_items" do
    page.should have_content(item_name)
  end
end
