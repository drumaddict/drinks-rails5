class ReoccuringOrders
  include Sidekiq::Worker

  def perform
    Order.place_reoccuring
  end

  def self.place
    perform_async
  end
end
