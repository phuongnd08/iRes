module OrdersHelper
  def mini_button_settings
    {
      :"data-role" => "button",
      :"data-inline" => "true",
      :"data-mini" => "true"
    }
  end

  def ajax_mini_button_settings
    mini_button_settings.merge!(
      :"data-remote" => true, :"data-method" => :put,
      :"data-ajax" => false,
    )
  end

  def mark_state_button_attributes(order_or_order_item, state)
    model_name = order_or_order_item.class.name.underscore
    path = send(:"change_state_#{model_name}_path", order_or_order_item, :state => state)
    mini_button_settings.merge!(
      :class => "mark-as-#{state}-btn #{order_or_order_item.send(:"mark_as_#{state}_visibility_class")}",
      :"data-icon" => "mark-as-#{state}",
      :"data-remote" => true, :"data-method" => :put, :"data-ajax" => false,
      :href => '#', :"data-href" => path
    )
  end
end
