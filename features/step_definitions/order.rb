Given /^an order of table (\d+) is committed$/ do |table_number|
  DataBag.order = Order.make!(:table_number => table_number)
end

Then /^I see (\d+) orders in the waiting list$/ do |count|
  wait_for count.to_i do
    page.all("ul.order_items").size
  end
end

Then /^I (do not )?see "([^"]*)" in waiting list$/ do |negate, text|
  within_waiting_list do
    if negate.blank?
      page.should have_content(text)
    else
      page.should have_no_content(text)
    end
  end
end

When /^the order of table (\d+) is cancelled$/ do |table_number|
  Order.find_by_table_number(table_number).destroy
end

Given /^an order is committed at (\d+):(\d+)$/ do |hour, minute|
  Order.record_timestamps = false
  now = Time.now
  ordered_time = Time.new(now.year, now.month, now.day, hour.to_i, minute.to_i)
  DataBag.order = Order.create(:created_at => ordered_time, :updated_at => ordered_time)
  Order.record_timestamps = true
end

When /^I mark order of table (\d+) as ready$/ do |table_number|
  within_waiting_list do
    order = Order.find_by_table_number(table_number)
    within "[data-order-id='#{order.id}']" do
      within "[role='heading']" do
        click_on I18n.t("order.ready")
      end
    end
  end
end

When /^the order is ready$/ do
  DataBag.order.update_attribute(:state, Order::STATE_READY)
end

Then /^I see star icon for order of table (\d+)$/ do |table_number|
  order = Order.find_by_table_number(table_number)
  page.find("ul#orders li[data-order-id='#{order.id}']").should have_css(".ui-icon-star")
end

When /^I see "([^"]*)" as the total price of order$/ do |total_price|
  within ".total_price_counter" do
    page.should have_content(total_price)
  end
end

Then /^I see "([^"]*)" as number of items of order$/ do |count|
  within ".item_counter" do
    page.should have_content count
  end
end

