def within_orders_as_seen_by_waiter
  within "#orders" do
    yield
  end
end

def within_the_order_as_seen_by_waiter order
  within_orders_as_seen_by_waiter do
    within "[data-order-id='#{order.id}']" do
      yield
    end
  end
end

Then /^I see the order(?: of table (\d+))? as (un)?(paid|ready|served)$/ do |table_number, negate, state|
  within_orders_as_seen_by_waiter do
    order = order_of_table(table_number)
    css = "ul[data-order-id='#{order.id}'] li[data-role='list-divider'][data-theme='#{order_color_for(state)}']"
    if negate
      page.should have_no_css css
    else
      page.should have_css css
    end
  end
end

Then /^I can(not)? mark the order(?: of table (\d+))? as (served|paid)$/ do |negate, table_number, state|
  within_orders_as_seen_by_waiter do
    order = order_of_table(table_number)
    order_css = "[data-order-id='#{order.id}']"
    button_css =  order_css + " .mark-as-#{state}-btn"
    if negate
      page.find(button_css).should_not be_visible
    else
      page.find(button_css).should be_visible
    end
  end
end

When /^I try to mark the order as (paid|served)$/ do |state|
  within_the_order_as_seen_by_waiter DataBag.order do
    find(".mark-as-#{state}-btn").click
  end
end

When /^I choose order of table (\d+)$/ do |table_number|
  within_the_order_as_seen_by_waiter Order.find_by_table_number(table_number) do
    find(".go-to-btn").click
  end
end

Then /^I cannot add item to the order$/ do
  page.should have_content I18n.t("order.not_modifiable")
end

Then /^I cannot delete the order$/ do
  page.should have_no_link I18n.t("buttons.cancel")
end

Then /^I cannot commit the order$/ do
  page.should have_no_button I18n.t("buttons.commit")
end

Then /^I see timing of order (\d+) reported as "([^"]*)"$/ do |table_number, time_string|
  within_the_order_as_seen_by_waiter(Order.find_by_table_number(table_number)) do
    page.should have_content time_string
  end
end
