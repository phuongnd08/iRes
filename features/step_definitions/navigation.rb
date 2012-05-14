When /^I choose "([^"]*)"$/ do |text|
  wait_for true do
    find_link(text).visible?
  end

  click_on text
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
  begin
    within ".ui-simpledialog-container" do
      click_on choice
    end
  end while !page.has_no_css?(".ui-simpledialog-container")
end
