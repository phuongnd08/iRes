def create_order(table_number, time = nil, table = nil)
  DataBag.order = Order.make!(:table_number => table_number)
  update_order_time(DataBag.order, :created_at, time) if time
  create_order_items(DataBag.order, table.hashes) if table
end

Given /^an order(?: of table (\d+))? is committed( (?:at \d+\:\d+|yesterday))?$/ do |table_number, time|
  create_order(table_number, time)
end

Given /^an order(?: of table (\d+))? is committed( (?:at \d+\:\d+|yesterday))? with these items:?$/ do |table_number, time, table|
  create_order(table_number, time, table)
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

When /^the order(?: of table (\d+))? is (cancelled|ready|served|paid)$/ do |table_number, state|
  order = order_of_table(table_number)
  if state == "cancelled"
    order.destroy
  else
    sleep 0.1
    order.update_attribute(state.to_sym, true)
  end
end

When /^I mark order of table (\d+) as ready$/ do |table_number|
  within_waiting_list do
    order = Order.find_by_table_number(table_number)
    within "[data-order-id='#{order.id}']" do
      within "[role='heading']" do
        find(".mark-as-ready-btn").click
      end
    end
  end
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

When /^(?:this|these) items? is added to the order:$/ do |table|
  create_order_items(DataBag.order.reload, table.hashes)
end

When /^the order is paid (at \d+:\d+)$/ do |time|
  time = chronic_time(time)
  Time.stub(:now).and_return(time)
  DataBag.order.update_attribute(:paid, true)
  Time.rspec_reset
end

Then /^I am able export the order to excel$/ do
  page.should have_link(I18n.t("buttons.export_to_excel"), :href => order_path(DataBag.order, :format => :xls))
end
