Then /^I see toast of "([^"]*)" with text "([^"]*)"$/ do |title, msg|
  within ".ui-toast:last" do
    page.should have_content title
    page.should have_content msg
  end
end

