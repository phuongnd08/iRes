module OrdersHelper
  def get_order_mark_state_button_attributes(order, state)
    {
      :class => "mark-as-#{state}-btn #{order.send(:"mark_as_#{state}_visibility_class")}",
      :"data-role" => "button",
      :"data-inline" => "true", :"data-icon" => "mark-as-#{state}", :"data-mini" => "true",
      :"data-remote" => true, :"data-method" => :put, :"data-ajax" => false,
      :href => '#', :"data-href" => send(:"mark_#{state}_order_path", order)
    }
  end
end
