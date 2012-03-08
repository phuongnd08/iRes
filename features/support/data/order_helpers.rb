def create_order_items(order, item_hashes)
  item_hashes.each do |hash|
    category = Category.find_by_name(hash['category'])
    raise "Category #{hash['category']} not found" unless category
    item = Item.find_by_category_id_and_name(category.id, hash['name'])
    order.order_items << OrderItem.new(:item => item)
  end

  order.save
end
