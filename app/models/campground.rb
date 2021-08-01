# frozen_string_literal: true

# Model for the Campgrounds
class Campground < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :campsites

  HIGHEST_PRICE = 10_000
  def available(start_date, end_date)
    booked_camps = future_booked_dates

    no_conflicts(start_date, end_date, booked_camps) ||
      campsites_not_booked?
  end

  # Any Campsite not booked at all or in the future?
  def campsites_not_booked?
    booked = true
    campsites.includes(:booked_dates).each do |campsite|
      booked &&= campsite.booked?
    end
    !booked
  end

  def booked_dates
    booked = []
    campsites.includes(:booked_dates).each do |camp|
      camp.booked_dates.each do |date|
        booked << {camp: camp.name,
                   check_in: date.check_in_date,
                   check_out: date.check_out_date}
      end
    end
    booked
  end

  def future_booked_dates
    booked = []
    campsites.includes(:booked_dates).each do |campsite|
      campsite.booked_dates.each do |date|
        next unless date.in_the_future

        booked << {campsite: campsite.name,
                   check_in: date.check_in_date,
                   check_out: date.check_out_date}
      end
    end
    booked
  end

  def price_range
    lowest = HIGHEST_PRICE
    highest = 0
    campsites.each do |camp|
      lowest = camp.price if camp.price < lowest
      highest = camp.price if camp.price > highest
    end
    [lowest, highest]
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
