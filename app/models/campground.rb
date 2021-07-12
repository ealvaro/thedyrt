# frozen_string_literal: true

# Model for the Campgrounds
class Campground < ApplicationRecord
  has_many :campsites

  def booked_dates
    booked = []
    campsites.each do |camp|
      camp.booked_dates.each do |date|
        booked << { camp: camp.name, check_in: date.check_in_date, check_out: date.check_out_date }
      end
    end
    booked
  end

  def price_range
    lowest = 1000
    highest = 0
    campsites.each do |camp|
      lowest = camp.price if camp.price < lowest
      highest = camp.price if camp.price > highest
    end
    (lowest..highest)
  end
end
