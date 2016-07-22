namespace :orders do
  desc "Place Reoccuring Orders"
  task reoccuring: :environment do
    Order.place_reoccuring
  end
end
