Then /^I see "([^"]*)" for (?:food|drink) "([^"]*)"$/ do |text, item_name|
  item = Item.find_by_name(item_name)
  within "#ordering" do
    within "li[data-item-id='#{item.id}']" do
      page.should have_content text
    end
  end
end

Given /^these items exists:$/ do |table|
  table.hashes.each do |hash|
    category = Category.find_or_create_by_name(hash["category"])
    Item.find_or_create_by_name_and_category_id(hash["name"], category.id, :price => 10000)
  end
end

When /^I assign the item name to blank$/ do
  fill_in "item_name", :with => ""
end

When /^I assign the item name to "([^"]*)"$/ do |name|
  fill_in "item_name", :with => name
end

When /^I assign the item price to blank$/ do
  fill_in "item_price", :with => ""
end

When /^I assign the item price to "([^"]*)"$/ do |price|
  fill_in "item_price", :with => price
end

Then /^category "([^"]*)" has item "([^"]*)"$/ do |category_name, item_name|
  Item.find_by_name(item_name).tap do |item|
    item.should_not be_nil
    item.category.name.should == category_name
  end
end

