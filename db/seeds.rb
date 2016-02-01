# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.new
user.email = "bogardon@gmail.com"
user.password = "hehehoho"
user.confirmed_at = Time.now
user.save

collaboration = Collaboration.new
collaboration.name = "Cloud 9"
collaboration.description = "Best CS:GO team in NA"
collaboration.save

membership = Membership.new
membership.user = user
membership.collaboration = collaboration
membership.save

tag = Tag.new
tag.name = "memes"
tag.save

platform = Platform.new
platform.name = "Twitter"
platform.save

post = Post.new
post.title = "Tweet of the century"
post.collaboration = collaboration
post.copy = "AYY LMAO?"
post.user = user
post.scheduled_at = Time.now
post.platform = platform
post.save

tagging = Tagging.new
tagging.tag = tag
tagging.post = post
tagging.save

platforms = ["Facebook", "Instagram"]
platforms.each do |name|
  p = Platform.new(name: name)
  p.save!
end
