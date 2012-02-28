Then /^I see (\d+) items being ordered$/ do |count|
  within_ordered_section do
    within "ul.items" do
      page.all("li").count.should == count.to_i
    end
  end
end

Then /^I (do not )?see "([^"]*)" in the ordered list$/ do |negate, item_name|
  within_ordered_section do
    within "ul.items" do
      if negate.present?
        page.should have_no_content(item_name)
      else
        page.should have_content(item_name)
      end
    end
  end
end

Then /^I see (\d+) items in the waiting list$/ do |count|
  within ".order_items" do
    page.all("li").count.should == count.to_i
  end
end

Then /^I see "([^"]*)" in the waiting list$/ do |item_name|
  within ".order_items" do
    page.should have_content(item_name)
  end
end
