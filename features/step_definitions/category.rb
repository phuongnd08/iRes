Given /^these categories exists:$/ do |table|
  table.hashes.each do |hash|
    Category.create(hash)
  end
end

When /^I assign the category name to blank$/ do
  fill_in "category_name", :with => ""
end

When /^I assign the category name to "([^"]*)"$/ do |name|
  fill_in "category_name", :with => name
end

Then /^I have "([^"]*)" category$/ do |name|
  Category.find_by_name(name).should be_present
end

