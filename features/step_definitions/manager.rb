Then /^I (?:still )?see collected revenue of (\d+)$/ do |revenue|
  wait_for(revenue) { find(".collected_revenue").text }
end

When /^I switch to (today|yesterday) statistics$/ do |day|
  click_on I18n.t("dates.#{day}")
end

