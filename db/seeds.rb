# encoding: utf-8

bun_bo = nil
hu_tieu = nil
com_ga = nil

Category.find_or_create_by_name("Đồ ăn").tap do |food|
  bun_bo = Item.find_or_create_by_name(:name => "Bún bò", :category_id => food.id, :price => 20000)
  hu_tieu = Item.find_or_create_by_name(:name => "Hủ tiếu mì", :category_id => food.id, :price => 25000)
  com_ga = Item.find_or_create_by_name(:name => "Cơm gà xối mỡ", :category_id => food.id, :price => 28000)
end

ca_phe = nil
ca_cao = nil
cam_vat = nil

Category.find_or_create_by_name("Đồ uống").tap do |drink|
  ca_phe = Item.find_or_create_by_name(:name => "Cà phê", :category_id => drink.id, :price => 10000)
  ca_cao = Item.find_or_create_by_name(:name => "Ca cao", :category_id => drink.id, :price => 12000)
  cam_vat = Item.find_or_create_by_name(:name => "Cam vắt", :category_id => drink.id, :price => 15000)
end

#(Order.find_by_id(1) || Order.new).tap do |order|
  #order.order_items << OrderItem.new(:item => bun_bo)
  #order.order_items << OrderItem.new(:item => com_ga)
  #order.order_items << OrderItem.new(:item => ca_phe)
  #order.save!
#end
