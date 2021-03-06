module OrderTimeMethods
  def create_order_items(order, item_hashes)
    item_hashes.each do |hash|
      category = Category.find_by_name(hash['category'])
      raise "Category #{hash['category']} not found" unless category
      item = Item.find_by_category_id_and_name(category.id, hash['name'])
      order.order_items << OrderItem.new(:item => item)
    end

    order.save
  end

  def order_of_table(table_number)
    if table_number.nil?
      DataBag.order
    else
      Order.find_by_table_number(table_number)
    end
  end

  def update_order_time(order, field, time)
    Order.record_timestamps = false
    order.update_attribute(field, chronic_time(time))
    Order.record_timestamps = true
  end

  def chronic_time(time)
    Chronic.parse(time) || Chronic.parse("today " + time)
  end
end

World(OrderTimeMethods)
