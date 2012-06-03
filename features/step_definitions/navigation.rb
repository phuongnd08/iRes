When /^I choose "([^"]*)"$/ do |text|
  click_on text
end

When /^I try to order$/ do
  wait_for true do
    find_link(I18n.t("waiter.order")).visible?
  end

  find_link(I18n.t("waiter.order")).click
end


Then /^I'm presented with the ([\w\s]+) page$/ do |path_name|
  expected_path = case path_name
                  when "new order" then new_order_path
                  else
                    raise "Unknown path: " + path_name
                  end
  wait_for(expected_path){ current_path }
end

Given /^I(?:'m| am) on (waiter|chef|manager) page$/ do |role|
  visit '/' + role
  page.should have_content I18n.t("#{role}.header")
end

Given /^I am on the categories page$/ do
  visit categories_path
end

When /^I confirm the dialog with "([^"]*)"$/ do |choice|
  page.should have_css(".ui-simpledialog-container")
  within ".ui-simpledialog-container" do
    link = find_link(choice)
    wait_for(true) { link.visible? }
    link.click
  end
end
