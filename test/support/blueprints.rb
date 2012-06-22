require 'machinist/active_record'

Order.blueprint do

end

Order.blueprint(:with_order_items) do
  order_items(1)
end

Item.blueprint do
  name { "Item #{sn}" }
  price { 10000 }
  category
end

OrderItem.blueprint do
  item
end

Category.blueprint do
  name { "Category #{sn}" }
end
