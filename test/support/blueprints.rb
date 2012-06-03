require 'machinist/active_record'

Order.blueprint do

end

Item.blueprint do
  name { "Item #{sn}" }
  price { 10000 }
  category
end

Category.blueprint do
  name { "Category #{sn}" }
end
