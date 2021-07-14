# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development? && AdminUser.find_by(email: 'admin@example.com').blank?

#the highest role with all the permissions.
Role.create!(:name => "Super Admin")
 
#other role
Role.create!(:name => "Staff")

#create a universal permission
Permission.create!(:subject_class => "all", :action => "manage")

#assign super admin the permission to manage all the models and controllers
role = Role.find_by_name('Super Admin')
role.permissions << Permission.find(:subject_class => 'all', :action => "manage")

# create a user and assign the super admin role to him.
user = User.new(:name => "Prasad Surase", :email => "prasad@joshsoftware.com", :password => "prasad", :password_confirmation => "prasad")
user.role = role
user.save!

User.create(:name => "Neo", email => "neo@matrix.com", :password => "the_one", :password_confirmation => "the_one", :role_id => Role.find_by_name('Staff').id)