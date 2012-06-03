Then /^I (do not )?see "([^"]*)"$/ do |negate, text|
  within "[data-role=page]" do
    if negate.blank?
      page.should have_content(text)
    else
      page.should have_no_content(text)
    end
  end
end

Then /^I (do not )?see notice "([^"]*)"$/ do |negate, text|
  within ".ui-loader" do
    if negate.blank?
      page.should have_content(text)
    else
      page.should have_no_content(text)
    end
  end
end
