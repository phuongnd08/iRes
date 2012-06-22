module OrderStateMethods
  include Css::Class

  def mark_as_ready_visibility_class
    ready ? HIDDEN : VISIBLE
  end

  def mark_as_paid_visibility_class
    paid ? HIDDEN : VISIBLE
  end

  def mark_as_served_visibility_class
    ready && !served ? VISIBLE : HIDDEN
  end

  def ready_icon_visibility_class
    ready ? VISIBLE : HIDDEN
  end

  def served_icon_visibility_class
    served ? VISIBLE : HIDDEN
  end

  def paid_icon_visibility_class
    paid ? VISIBLE : HIDDEN
  end
end
