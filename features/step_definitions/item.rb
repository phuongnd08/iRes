Then /^I see "([^"]*)" for (?:food|drink) "([^"]*)"$/ do |text, item_name|
  item = Item.find_by_name(item_name)
  within "#ordering" do
    within "li[data-item-id='#{item.id}']" do
      page.should have_content text
    end
  end
end

