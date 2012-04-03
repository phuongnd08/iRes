require 'machinist/active_record'

Order.blueprint do

end

Item.blueprint do
  name { |sn| "Item #{sn}" }
  category
end

Category.blueprint do
  name { |sn| "Category #{sn}" }
end
