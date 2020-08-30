# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

a = User.create(username: "Amelie", password: "common")
j = User.create(username: "Jeff", password: "common")

f = Friendship.create(user: a, friend: j)

Category.create(title: "Meals", user: j, friendship: f)
Category.create(title: "Movies", user: a, friendship: f)
Category.create(title: "Outdoor Activities", user: a)
Category.create(title: "Restaurants", user: a)
Category.create(title: "Games", user: j)
Category.create(title: "Indoor Activities", user: j)

30.times do
  Item.create(title: Faker::Movie.title, category: Category.all.sample)
end

30.times do
  Rating.create(user: User.all.sample, item: Item.all.sample)
end
