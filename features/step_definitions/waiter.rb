def within_ordered_section
  within "#order_page" do
    find("[data-role=header] a[data-nav-to='#ordered']").click
    within "#ordered" do
      yield
    end
  end
end

def within_ordering_section
  within "#order_page" do
    find("[data-role=header] a[data-nav-to='#ordering']").click
  end
  within "#ordering" do
    yield
  end
end

When /^I choose "([^"]*)"$/ do |text|
  click_on text
end

When /^I choose item "([^"]*)"$/ do |text|
  within_ordering_section do
    click_on text
  end
end

When /^I choose "([^"]*)" as table number$/ do |table_number|
  select table_number, :from => 'order_table_number'
end

Then /^I see "([^"]*)" in ordered list$/ do |item_name|
  within_ordered_section do
    page.should have_content item_name
  end
end

When /^I commit the order$/ do
  within_ordered_section do
    click_on I18n.t("order.commit")
  end
end

When /^I stop committing the order$/ do
  within_ordered_section do
    click_on I18n.t("order.back")
  end
end

When /^I cancel the order$/ do
  within_ordered_section do
    click_on I18n.t("order.cancel")
  end
end

Then /^I see no orders$/ do
  within "#orders" do
    page.all('li').length.should == 1 #For the list divider
  end
end

