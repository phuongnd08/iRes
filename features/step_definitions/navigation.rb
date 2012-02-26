Then /^I'm presented with the ([\w\s]+) page$/ do |path_name|
  expected_path = case path_name
                  when "new order" then new_order_path
                  else
                    raise "Unknown path: " + path_name
                  end
  wait_for(expected_path){ current_path }
end

