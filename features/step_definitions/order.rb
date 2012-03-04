Given /^an order of table (\d+) is committed$/ do |table_number|
    Order.make!(:table_number => table_number)
end
