Given /^(?:these items are|this item is) ordered:$/ do |table|
  create_order_items(Order.new, table.hashes)
end

When /^(?:these items are|this item is) removed:$/ do |table|
  table.hashes.each do |hash|
    category = Category.find_by_name(hash['category'])
    raise "Category #{hash['category']} not found" unless category
    item = Item.find_by_category_id_and_name(category.id, hash['name'])
    OrderItem.find_by_item_id(item.id).destroy
  end
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

Then /^I see (\d+) items in the waiting list being marked as ready$/ do |count|
  within ".order_items" do
    wait_for count.to_i do
      page.all("li[data-order-item-id] span.ui-btn-up-" + Css::Theme::READY).count
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

When /^I mark item "([^"]*)" as ready$/ do |item_name|
  within_waiting_list do
    item = Item.find_by_name(item_name)
    order_item = OrderItem.find_by_item_id(item.id)
    within "[data-order-item-id='#{order_item.id}']" do
      find(".mark-as-ready-btn").click
    end
  end
end

Given /^item "([^"]*)" is marked as ready$/ do |item_name|
  item = Item.find_by_name(item_name)
  OrderItem.find_by_item_id(item.id).update_attribute(:ready, true)
end

Then /^I cannot remove "([^"]*)" from ordered list$/ do |item_name|
  within_ordered_section do
    Item.find_by_name(item_name).tap do |item|
      within "li[data-item-id='#{item.id}']" do
        find(".remove").should_not be_visible
      end
    end
  end
end

When /^I remove "([^"]*)" from ordered list$/ do |item_name|
  within_ordered_section do
    Item.find_by_name(item_name).tap do |item|
      within "li[data-item-id='#{item.id}']" do
        find(".remove").click
      end
    end
  end
end

