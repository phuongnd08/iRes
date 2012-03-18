Then /^I'm presented with the ([\w\s]+) page$/ do |path_name|
  expected_path = case path_name
                  when "new order" then new_order_path
                  else
                    raise "Unknown path: " + path_name
                  end
  wait_for(expected_path){ current_path }
end

Given /^I'm on waiter page$/ do
  visit '/waiter'
  page.should have_content I18n.t("waiter.order")
end

When /^I'm on chef page$/ do
  visit "/chef"
  page.should have_content I18n.t("ordered_items.header")
end

When /^I confirm the dialog with "([^"]*)"$/ do |choice|
  within ".ui-simpledialog-container" do
    click_on choice
  end
end
