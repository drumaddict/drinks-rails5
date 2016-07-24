# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
#
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



companies_list = [
  [ "Digerati" ],
  [ "Skroutz"],
  [ "e-Travel"],
  [ "Crypteia"],
  [ "Incrediblue"],
  [ "Workable"],
  [ "Beenotes"],
  [ "Generation Y"],
  [ "Persado" ]
]

companies_list.each do |company|
  instance_variable_set "@#{company[0].tableize.singularize.singularize.gsub(' ','_')}".to_sym, Company.create( name: company[0] )
end

users_list= [

  ["spiros", 'spiros@gmail.com', '11111111', '11111111',0 ,@digerati],
  ["chris", 'chris@gmail.com', '22222222', '22222222',0 , @digerati],
  ["john", 'john@gmail.com', '33333333', '33333333',1 , @digerati],
  ["gus", 'gus@gmail.com', '44444444', '44444444',0 , @digerati],
  ["mary", 'mary@gmail.com', '55555555', '55555555',0 , @crypteium],
  ["bob", 'bob@gmail.com', '66666666', '66666666',0 , @persado]
]

@users = []
users_list.each do |user|

  @user=User.new( name: user[0], email: user[1], password: user[2], password_confirmation: user[3], role:  user[4])
  @user.company_id= user[5].id
  @user.save
  @users << @user
  instance_variable_set("@#{user[0].tableize.singularize.singularize.gsub(' ','_')}".to_sym, @user )
end


drink_category_list= [
  ["Coffee",true, true],
  ["Juice",false, false],
  ["Tea",true, true],
  ["Cocktail",false, false]
]


drink_category_list.each do |dc|
  instance_variable_set "@#{dc[0].tableize.singularize.singularize.gsub(' ','_')}".to_sym, DrinkCategory.create( name: dc[0] , has_sugar:dc[1], has_milk:dc[2])
end


drinks_list= [
  ["Espresso", @coffee],
  ["Cappuccino", @coffee],
  ["Filter", @coffee],
  ["Greek", @coffee],
  ["Frappe", @coffee],
  ["Latte", @coffee],
  ["Orange", @juice],
  ["Banana", @juice],
  ["Apple", @juice],
  ["Lipton Ice Tea", @tea],
  ["Lemon Tea", @tea],
  ["Margarita", @cocktail],
  ["Pina Colada", @cocktail],
  ["Mojito", @cocktail]

]

drinks_list.each do |drink|

  @drink=Drink.new( name: drink[0] )
  @drink.drink_category_id= drink[1].id
  @drink.save

end



#Create sample orders
36.times do

  drink1=Drink.all.sample
  drink2 = Drink.all.sample

  line_item_1= LineItem.new
  line_item_1.drink =drink1
  line_item_1.drink_category =drink1.drink_category
  line_item_1.quantity = (1..4).to_a.sample
  line_item_1.sugar= line_item_1.drink_category.has_sugar ? (0..5).to_a.sample : 0
  line_item_1.milk= line_item_1.drink_category.has_milk ? (0..5).to_a.sample : 0


  line_item_2= LineItem.new
  line_item_2.drink =drink2
  line_item_2.drink_category =drink2.drink_category
  line_item_2.quantity = (1..4).to_a.sample
  line_item_2.sugar= line_item_2.drink_category.has_sugar ? (0..5).to_a.sample : 0
  line_item_2.milk= line_item_2.drink_category.has_milk ? (0..5).to_a.sample : 0


  user = @users.sample
  order = Order.new
  order.user = user

  order.line_items.push(line_item_1)
  order.line_items.push(line_item_2)

  order.status = 0
  order.favorite = [true,false].sample
  order.reoccuring = [true,false].sample
  if order.reoccuring
    order.hour = (9..15).to_a.sample
    order.days = (0..6).to_a.sample(4)
  end
  order.save(validate: false)


end







