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
    sleep 0.5
    link.click
  end

  page.should have_no_css(".ui-simpledialog-screen")
end

Given /^I observe if the page is reloaded$/ do
  page.execute_script(%{
    $.mobile.changePage = function (to, options) {
      window.changePageTo = to;
      window.changePageOptions = options;
    }
  })
end

When /^I pull the page down$/ do
  sleep 1
  within_active_page do
    page.execute_script("window.focus()")
    page.find(".ui-header").drag_to(page.find(".ui-content"))
  end
end

Then /^the page is reloaded$/ do
  wait_for("/waiter") { page.evaluate_script("window.changePageTo") }
  wait_for(true) { page.evaluate_script("window.changePageOptions.reloadPage") }
end
