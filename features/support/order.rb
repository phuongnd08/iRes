module OrderFeatureHelpers
  COLORS_HASH = {
    :unready => "red",
    :ready => "yellow",
    :served => "green",
    :paid => "blue"
  }

  def order_color_for(state)
    COLORS_HASH[state.to_sym]
  end
end

World(OrderFeatureHelpers)
