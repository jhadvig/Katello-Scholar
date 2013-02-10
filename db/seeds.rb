# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#admin = User.create :name => "admin", :email => "admin@admin.com", :password => "admin"

roles = {"admin"=>1, "lector"=>2, "student"=>3 }

Role.delete_all

roles.each do |k,v|
	Role.create!(:name=>k, :value=>v)

end