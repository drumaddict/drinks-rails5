class PlaceOrderJob < ApplicationJob
  queue_as :default

  def perform()
    # Do something later
    Order.reoccuring.each do |order|
      @duplicated_order = order.duplicate
      @duplicated_order.save
    end
  end
end
