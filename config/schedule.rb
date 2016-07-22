# bundle exec whenever -i To add cron job
# tail -f log/cron.log To see the cron tab logs
# crontab -e To see what has been written to cron tab
# bundle exec sidekiq To start sidekiq

env :PATH, ENV['PATH']
env :GEM_PATH, ENV['GEM_PATH']
# For Development only. Heroku does not support cron, instead providing Heroku Scheduler
set :environment, :development
set :output, {:error => "log/cron.log", :standard => "log/cron.log"}
# Use this file to easily define all of your cron jobs.
job_type :sidekiq, "cd :path && :environment_variable=:environment  bundle exec sidekiq-client push :task :output"

# Job defined in app/workers/reoccuring_orders.rb
every :hour  do
  sidekiq "ReoccuringOrders"
end
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
