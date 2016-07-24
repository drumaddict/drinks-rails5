# Drinks
----
## Overview
 A simple management system for daily company drink orders built with Rails 5 and Postgres. Just for the fun of it.

![screenshot](https://github.com/drumaddict/drinks-rails5/blob/master/orders.png)
![screenshot](https://github.com/drumaddict/drinks-rails5/blob/master/form.png)


## Features
### Authentication
 With  [has_secure_password](http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html#method-i-has_secure_password)
### Authorization
 Enum `role` field, (`employee`, `manager`).

### Order CRUD
Users can create update and delete orders.
### Nested Order Form
Drink items can be added with [Coccoon gem.](https://github.com/nathanvda/cocoon)
Upon drink category selection, an AJAX call fetches the drinks and populates the select input options.
Milk and sugar options are enabled/disabled with javascript based on whether the drink category is
served with these add-ons.
### Order status
In Progress, Complete, Cancelled. Only manager can change status.

### Favorite Orders
Favorite orders can be placed again and again with a push of a button.
### Reoccuring Orders
System places orders for you at the specified days of the week and time.
Implemented with [sidekiq](https://github.com/mperham/sidekiq), [sidekiq-client-cli](https://github.com/didil/sidekiq-client-cli),
[whenever](https://github.com/javan/whenever)

### Cancelled Orders
Manager can cancel an order either by editing status or with a handy cancel button in orders list.
Cancelled orders appear faded out in orders list with.

### Manage Drinks and Drink Categories
 Manager can create, update and delete drinks and drink categories.

### Filters
Orders can be filtered by user company, status(manager only), favorite, reoccuring.
Implemented with [has_scope gem](https://github.com/plataformatec/has_scope)

### Styling
No surprise here:  [bootstrap](https://github.com/twbs/bootstrap-rubygem),
with my little custom twist.

### View Template Engine.
Needless to say [Haml](http://haml.info/),
although I might switch to [Slim](http://slim-lang.com/) in the future.
The view rendering overhead is not a serious concern as people might try to tell you, specially
 when heavy views can be cached anyway.Surprisingly enough, [some](http://blog.crowdint.com/2013/07/17/view-engines-performance.html) benchmarks do not show a big
 performance difference among template engines. The maintainability and  cleanliness of Haml and Slim in my opinion outweighs any performance concern. Endless opening and closing tags (and hunting for missing ones) is not a sport I like to engage into.

## Usage

Clone repo, run `bundle exec install` , `rails db:create`, `rails db:migrate`, `rails db:seed`.

  To schedule reoccuring orders:
* `bundle exec whenever -i` To add cron job declared in `config/schedule.rb`
* `tail -f log/cron.log` To watch  cron logging.
*  `crontab -e` To see what has been written to cron tab.
* `bundle exec sidekiq` To start sidekiq

## Non Core gems used
* [Active Model Serializers](https://github.com/rails-api/active_model_serializers) for serializing JSON
* [has_scope](https://github.com/plataformatec/has_scope)  for parameter filtering
* [Kaminari](https://github.com/amatsuda/kaminari) for pagination
* [Simple Form](https://github.com/plataformatec/simple_form) for cleaner forms
* [Coccoon](https://github.com/nathanvda/cocoon) For adding fields in nested forms with javascript
* [Bootstrap RubyGem](https://github.com/twbs/bootstrap-rubygem)
* [Haml for Rails](https://github.com/indirect/haml-rails)

## License
 [MIT License](http://opensource.org/licenses/MIT).

