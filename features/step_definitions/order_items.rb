Then /^I see (\d+) items being listed$/ do |count|
  within ".order_items" do
    page.all("li").count.should == count.to_i
  end
end

Then /^I see "([^"]*)" in the ordered list$/ do |item_name|
  within ".order_items" do
    page.should have_content(item_name)
  end
end
