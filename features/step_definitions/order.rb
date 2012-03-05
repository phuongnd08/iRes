Given /^an order of table (\d+) is committed$/ do |table_number|
  Order.make!(:table_number => table_number)
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
  Order.create(:created_at => ordered_time, :updated_at => ordered_time)
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
