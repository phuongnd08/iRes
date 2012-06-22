module OrdersHelper
  def mark_state_button_attributes(order_or_order_item, state)
    model_name = order_or_order_item.class.name.underscore
    path = send(:"change_state_#{model_name}_path", order_or_order_item, :state => state)
    {
      :class => "mark-as-#{state}-btn #{order_or_order_item.send(:"mark_as_#{state}_visibility_class")}",
      :"data-role" => "button",
      :"data-inline" => "true", :"data-icon" => "mark-as-#{state}", :"data-mini" => "true",
      :"data-remote" => true, :"data-method" => :put, :"data-ajax" => false,
      :href => '#', :"data-href" => path
    }
  end
end
