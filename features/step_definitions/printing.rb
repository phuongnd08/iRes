Given /^I watch if the printer is printing$/ do
  Printer.stub(:print) do |arg|
    DataBag.printing = arg
  end
end

When /^I try to print the order$/ do
  within_the_order_as_seen_by_waiter DataBag.order do
    find(".print-btn").click
  end
end

Then /^the printer prints$/ do
  wait_for(true) { DataBag.printing.present? }
  Pathname.new(DataBag.printing).tap do |path|
    path.should be_exist
    path.size.should > 0
  end
end
