# encoding: utf-8

Category.find_or_create_by_name("Đồ ăn").tap do |food|
  Item.find_or_create_by_category_id_and_name(food.id, "Bún bò")
  Item.find_or_create_by_category_id_and_name(food.id, "Hủ tiếu mì")
  Item.find_or_create_by_category_id_and_name(food.id, "Cơm gà xối mỡ")
end

Category.find_or_create_by_name("Đồ uống").tap do |drink|
  Item.find_or_create_by_category_id_and_name(drink.id, "Cà phê đen")
  Item.find_or_create_by_category_id_and_name(drink.id, "Ca cao")
  Item.find_or_create_by_category_id_and_name(drink.id, "Cam vắt")
end
