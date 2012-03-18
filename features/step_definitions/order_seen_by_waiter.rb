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

Then /^I see the order as (un)?paid$/ do |negate|
  within_orders_as_seen_by_waiter do
    paid_icon_css = "[data-order-id='#{DataBag.order.id}'] .ui-icon-paid"
    paid_button_css = "[data-order-id='#{DataBag.order.id}'] .mark-as-paid-btn"
    if negate
      page.should have_no_css paid_icon_css
      page.find(paid_button_css).should be_visible
    else
      page.should have_css paid_icon_css
      page.find(paid_button_css).should_not be_visible
    end
  end
end

When /^I try to mark the order as paid$/ do
  within_an_order_as_seen_by_waiter DataBag.order do
    click_on I18n.t("buttons.mark_paid")
  end
end

