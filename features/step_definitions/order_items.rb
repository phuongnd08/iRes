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

When /^(?:these items are|this item is) removed:$/ do |table|
  table.hashes.each do |hash|
    category = Category.find_by_name(hash['category'])
    raise "Category #{hash['category']} not found" unless category
    item = Item.find_by_category_id_and_name(category.id, hash['name'])
    OrderItem.find_by_item_id(item.id).destroy
  end
end

Given /^an order of table (\d+) is committed with these items:$/ do |number, table|
  create_order_items(Order.create(:table_number => number.to_i), table.hashes)
end

Then /^I see (\d+) items being ordered$/ do |count|
  within_ordered_section do
    within "ul.items" do
      page.all("li").count.should == count.to_i
    end
  end
end

Then /^I (do not )?see "([^"]*)" in the ordered list$/ do |negate, item_name|
  within_ordered_section do
    within "ul.items" do
      if negate.present?
        page.should have_no_content(item_name)
      else
        page.should have_content(item_name)
      end
    end
  end
end

Then /^I see (\d+) items in the waiting list$/ do |count|
  within ".order_items" do
    wait_for count.to_i do
      page.all("li[data-order-item-id]").count
    end
  end
end

Then /^I (do not )?see "([^"]*)" in the waiting list$/ do |negate, item_name|
  within ".order_items" do
    if negate
      page.should have_no_content(item_name)
    else
      page.should have_content(item_name)
    end
  end
end
