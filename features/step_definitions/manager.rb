Then /^I see collected revenue of (\d+)$/ do |revenue|
  within ".collected_revenue" do
    page.should have_content(revenue)
  end
end

