# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.new
u.email = "bogardon@gmail.com"
u.password = "hehehoho"
u.confirmed_at = Time.now
u.save

c = Collaboration.new
c.name = "Cloud 9"
c.description = "Best CS:GO team in NA"
c.save

m = Membership.new
m.user = u
m.collaboration = c
m.save

p = Post.new
p.name = "Cluj"
p.collaboration = c
p.user = u
p.scheduled_at = Time.now
p.save
