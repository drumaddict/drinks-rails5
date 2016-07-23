module ApplicationHelper

  def link_class(path)
    class_name = current_page?(path) ? 'active' : ''
  end

  def cancelled_class(order)
    order.cancelled? ? 'cancelled' : ''
  end
end
