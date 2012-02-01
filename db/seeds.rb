# encoding: utf-8

bun_bo = nil
hu_tieu = nil
com_ga = nil

Category.find_or_create_by_name("Đồ ăn").tap do |food|
  bun_bo = Item.find_or_create_by_category_id_and_name(food.id, "Bún bò")
  hu_tieu = Item.find_or_create_by_category_id_and_name(food.id, "Hủ tiếu mì")
  com_ga = Item.find_or_create_by_category_id_and_name(food.id, "Cơm gà xối mỡ")
end

ca_phe = nil
ca_cao = nil
cam_vat = nil

Category.find_or_create_by_name("Đồ uống").tap do |drink|
  ca_phe = Item.find_or_create_by_category_id_and_name(drink.id, "Cà phê đen")
  ca_cao = Item.find_or_create_by_category_id_and_name(drink.id, "Ca cao")
  cam_vat = Item.find_or_create_by_category_id_and_name(drink.id, "Cam vắt")
end

(Order.find_by_id(1) || Order.new).tap do |order|
  order.order_items << OrderItem.new(:item => bun_bo)
  order.order_items << OrderItem.new(:item => com_ga)
  order.order_items << OrderItem.new(:item => ca_phe)
  order.save!
end
