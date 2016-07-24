# Drinks
----
### Overview
 A simple management system for daily company drink orders built with Rails 5.

![screenshot](https://github.com/drumaddict/drinks-rails5/blob/master/orders.png)
![screenshot](https://github.com/drumaddict/drinks-rails5/blob/master/form.png)

## Features
### Authentication
 With `has_secure_password`
### Authorization
 Roles, (`employee`, `manager`).
### Nested Order Form
Add drink items with [Coccoon gem.](https://github.com/nathanvda/cocoon)
Drinks selections are filtered with javascript based on drink category selection.
Milk and sugar options are enabled/disabled with javascript based on whether the drink category is
served with these add-ons.
### Order status
In Progress, Complete, Cancelled. Only manager can change status.

### Favorite Orders
Place your favorite orders again and again with a push of a button.
### Reoccuring Orders
System places orders for you at the specified days of the week and time.
Implemented with [sidekiq](https://github.com/mperham/sidekiq), [sidekiq-client-cli](https://github.com/didil/sidekiq-client-cli),
[whenever](https://github.com/javan/whenever)

### Manage Drinks and Drink Categories
 Manager can create, update and delete drinks and drink categories.

### Filters
Orders can be filtered by user company, status(manager only), favorite, reoccuring.
Implemented with [has_scope gem](https://github.com/plataformatec/has_scope)

## Usage

Clone repo, run `bundle exec install` , `rails db:create`, `rails db:migrate`, `rails db:seed`.

  To schedule reoccuring orders:
* `bundle exec whenever -i` To add cron job declared in `config/schedule.rb`
* `tail -f log/cron.log` To watch  cron logging.
*  `crontab -e` To see what has been written to cron tab.
* `bundle exec sidekiq` To start sidekiq

## License
 [MIT License](http://opensource.org/licenses/MIT).
