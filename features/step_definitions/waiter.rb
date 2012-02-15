def within_ordered_list
  page.execute_script("$.mobile.changePage('#ordered_page')")
  yield
end

def within_ordering_list
  page.execute_script("$.mobile.changePage('#ordering_page')")
  yield
end

Given /^I'm on waiter page$/ do
  visit '/waiter'
end

When /^I choose "([^"]*)"$/ do |text|
  click_on text
end

When /^I choose item "([^"]*)"$/ do |text|
  within_ordering_list do
    click_on text
  end
end

When /^I choose "([^"]*)" as table number$/ do |table_number|
  select table_number, :from => 'order_table_number'
end

Then /^I see "([^"]*)"$/ do |text|
  within "[data-role=page]" do
    page.should have_content(text)
  end
end

Then /^I see "([^"]*)" in ordered list$/ do |item_name|
  within_ordered_list do
    page.should have_content item_name
  end
end

Then /^I see "([^"]*)" within ordered statistics$/ do |count|
  within_ordered_list do
    within ".counter" do
      page.should have_content count
    end
  end
end

When /^I commit the order$/ do
  click_on I18n.t("order.ordered")
  within_ordered_list do
    click_on I18n.t("order.commit")
  end
end
