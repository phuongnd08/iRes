Given /^an order of table (\d+) is committed$/ do |table_number|
  Order.make!(:table_number => table_number)
end

Then /^I see (\d+) orders in the waiting list$/ do |count|
  wait_for count.to_i do
    page.all("ul.order_items").size
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

