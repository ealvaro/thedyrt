# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
TOTAL_CAMPGROUNDS = 1000
CAMPSITES_PER_CAMP = 4
BOOKED_CAMPSITES_PER_CAMP = 3
LOWEST_PRICE = 35
HIGHEST_PRICE = 199
MAX_DAYS_BOOKED_IN_ADVANCE = 90

TOTAL_CAMPGROUNDS.times do
  # Campground name must be unique so we add a random Roman numeral to the name
  name = Faker::Mountain.name
  Campground.create!(
    name: "#{name} #{rand(1..TOTAL_CAMPGROUNDS).roman}"
  )
rescue ActiveRecord::RecordInvalid
  next
end
# Want X Campsites per Campground as sample data
(Campground.all.count * CAMPSITES_PER_CAMP).times do |index|
  Campsite.create!(
    name: Faker::Alphanumeric.alphanumeric(number: 10),
    price: Faker::Number.between(from: LOWEST_PRICE, to: HIGHEST_PRICE),
    campground: Campground.find(index / CAMPSITES_PER_CAMP + 1)
  )
end
# Want Y times the number of Campgrounds with Campsites booked in the future
(Campground.all.count * BOOKED_CAMPSITES_PER_CAMP).times do |index|
  rnd_date = Faker::Date.forward(days: MAX_DAYS_BOOKED_IN_ADVANCE)
  BookedDate.create!(
    campsite: Campsite.find(index + 1),
    check_in_date: rnd_date,
    check_out_date: rnd_date + rand(1..MAX_DAYS_BOOKED_IN_ADVANCE / 2).days
  )
end
