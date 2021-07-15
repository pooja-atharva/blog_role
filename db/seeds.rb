# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development? && AdminUser.find_by(email: 'admin@example.com').blank?

#the highest role with all the permissions.
Role.create!(:name => "Admin")
Role.create!(:name => "Employee")

#create a universal permission
Permission.create!(:subject_class => "all", :action => "manage")

#assign super admin the permission to manage all the models and controllers
role = Role.find_by_name('Admin')
role.permissions << Permission.where(:subject_class => 'all', :action => "manage").first

# create a user and assign the super admin role to him.
user = User.new(:email => "pooja@atharvasystem.com", :password => "123123", :password_confirmation => "123123")
user.role = role
user.save!

User.create(:email => "poojam@gmail.com", :password => "123123", :password_confirmation => "123123", :role_id => Role.find_by_name('Employee').id)

