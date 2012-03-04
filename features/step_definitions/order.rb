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


