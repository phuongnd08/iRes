module RouteHelpers
  def helper
    IRes::Application.routes.url_helpers
  end

  [:order_path, :orders_path].each do |sym|
    define_method sym do |*args|
      helper.send(sym, *args)
    end
  end
end
