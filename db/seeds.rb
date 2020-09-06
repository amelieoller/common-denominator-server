# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

a = User.create(username: "amelie", password: "common")
j = User.create(username: "jeff", password: "common")

f = Friendship.create(user: a, friend: j)

categories = ["Meals", "Movies", "Games", "Indoor Activities"]

categories.each do |category|
  Category.create(title: category, user: a, custom_friendship_id: "#{a.id}_#{j.id}")
end

30.times do
  Item.create(title: Faker::Movie.title, category: Category.all.sample)
end

30.times do
  Rating.create(user: User.all.sample, item: Item.all.sample, value: rand(0..10))
end
