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
  [ "Lumia"],
  [ "Microsoft" ],
  [ "Google"],
  [ "Persado" ]
]

companies_list.each do |company|
  instance_variable_set "@#{company[0].tableize.singularize.singularize.gsub(' ','_')}".to_sym, Company.create( name: company[0] )

end

# binding.pry
users_list= [

  ["spiros", 'spiros@gmail.com', '11111111', '11111111',0 ,@digerati],
  ["chris", 'chris@gmail.com', '22222222', '22222222',0 , @lumium],
  ["john", 'john@gmail.com', '33333333', '33333333',1 , @digerati],
  ["don", 'don@gmail.com', '55555555', '55555555',0 , @digerati],
  ["mary", 'mary@gmail.com', '66666666', '66666666',0 , @digerati],
  ["bob", 'bob@gmail.com', '77777777', '77777777',0 , @lumium]


]


users_list.each do |user|

  @user=User.new( name: user[0], email: user[1], password: user[2], password_confirmation: user[3], role:  user[4])
  @user.company_id= user[5].id
  @user.save

  # instance_variable_set("@#{user[0].tableize.singularize.singularize.gsub(' ','_')}".to_sym, @user )
end



