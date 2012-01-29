Given /^I'm on waiter page$/ do
  visit '/waiter'
end

When /^I choose "([^"]*)"$/ do |text|
  click_on text
end

When /^I choose "([^"]*)" as table number$/ do |table_number|
  within "#table_selector_page" do
    click_on table_number
  end
end

Then /^I see "([^"]*)"$/ do |text|
  within "[data-role=page]" do
    page.should have_content(text)
  end
end

When /^I choose "([^"]*)" category$/ do |arg1|
    pending # express the regexp above with the code you wish you had
end

Then /^I see "([^"]*)" in ordered list$/ do |arg1|
    pending # express the regexp above with the code you wish you had
end

Then /^I see statistics "([^"]*)"$/ do |arg1|
    pending # express the regexp above with the code you wish you had
end


