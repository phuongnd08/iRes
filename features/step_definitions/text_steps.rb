Then /^I (do not )?see "([^"]*)"$/ do |negate, text|
  within "[data-role=page]" do
    if negate.blank?
      page.should have_content(text)
    else
      page.should have_no_content(text)
    end
  end
end
