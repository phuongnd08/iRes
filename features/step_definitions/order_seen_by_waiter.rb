def within_orders_as_seen_by_waiter
  within "#orders" do
    yield
  end
end

def within_an_order_as_seen_by_waiter order
  within_orders_as_seen_by_waiter do
    within "[data-order-id='#{order.id}']" do
      yield
    end
  end
end

Then /^I see the order as (un)?(paid|served)$/ do |negate, state|
  within_orders_as_seen_by_waiter do
    order_css = "[data-order-id='#{DataBag.order.id}']"
    paid_icon_css =  order_css + " .ui-icon-#{state}"
    paid_button_css = order_css + " .mark-as-#{state}-btn"
    if negate
      page.should have_no_css paid_icon_css
      page.find(paid_button_css).should be_visible
    else
      page.should have_css paid_icon_css
      page.find(paid_button_css).should_not be_visible
    end
  end
end

When /^I try to mark the order as (paid|served)$/ do |state|
  within_an_order_as_seen_by_waiter DataBag.order do
    click_on I18n.t("buttons.mark_#{state}")
  end
end

