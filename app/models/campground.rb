# frozen_string_literal: true

# Model for the Campgrounds
class Campground < ApplicationRecord
  has_many :campsites

  def available(start_date, end_date)
    # byebug
    booked_camps = future_booked_dates

    no_conflicts(start_date, end_date, booked_camps)
  end

  def booked_dates
    booked = []
    campsites.each do |camp|
      camp.booked_dates.each do |date|
        booked << { camp: camp.name,
                    check_in: date.check_in_date,
                    check_out: date.check_out_date }
      end
    end
    booked
  end

  def future_booked_dates
    booked = []
    campsites.each do |campsite|
      campsite.booked_dates.each do |date|
        next unless date.in_the_future

        booked << { campsite: campsite.name,
                    check_in: date.check_in_date,
                    check_out: date.check_out_date }
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

  private

  def no_conflicts(start_date, end_date, booked_camps)
    range_wanted = start_date..end_date
    booked_camps.each do |booked|
      range_booked = booked[:check_in]..booked[:check_out]
      next if range_booked.cover?(range_wanted.begin) || range_booked.cover?(range_wanted.end)
      next if range_wanted.cover?(range_booked.begin) || range_wanted.cover?(range_booked.end)

      return true
    end
    false
  end
end
