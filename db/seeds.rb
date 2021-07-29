# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Time slots during the next 14 days

1000.times do
  # Campground name must be unique so we add a random Roman numeral to the name
  name = Faker::Mountain.name
  Campground.create!(
    name: "#{name} #{rand(1..1000).roman}"
  )
rescue ActiveRecord::RecordInvalid
  next
end

(Campground.all.count * 4).times do |index|
  Campsite.create!(
    name: Faker::Alphanumeric.alphanumeric(number: 10),
    price: Faker::Number.between(from: 35, to: 199),
    campground: Campground.find(index / 4 + 1)
  )
end

(Campground.all.count * 4).times do |index|
  rnd_date = Faker::Date.forward(days: 90)
  BookedDate.create!(
    campsite: Campsite.find(index + 1),
    check_in_date: rnd_date,
    check_out_date: rnd_date + rand(1..21).days
  )
end
