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
  order = order_of_table(table_number)
  within_orders_as_seen_by_waiter do
    order_css = "[data-order-id='#{order.id}']"
    icon_css =  order_css + " .ui-icon-#{state}"
    if negate
      page.should have_no_css icon_css
    else
      page.should have_css icon_css
    end
  end
end

Then /^I cannot mark the order as (served|paid)$/ do |state|
  within_orders_as_seen_by_waiter do
    order_css = "[data-order-id='#{DataBag.order.id}']"
    button_css =  order_css + " .ui-icon-#{state}"
    page.should have_no_css button_css
  end
end

When /^I try to mark the order as (paid|served)$/ do |state|
  within_the_order_as_seen_by_waiter DataBag.order do
    click_on I18n.t("buttons.mark_#{state}")
  end
end

When /^I choose order of table (\d+)$/ do |table_number|
  within_the_order_as_seen_by_waiter Order.find_by_table_number(table_number) do
    find(".go-to-btn").click
  end
end
