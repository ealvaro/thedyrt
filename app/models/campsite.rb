# frozen_string_literal: true

# Model for the Campsites
class Campsite < ApplicationRecord
  belongs_to :campground
  has_many :booked_dates
  validates_presence_of :campground

  def booked?
    booked_dates.each do |booked_date|
      return true if booked_date.in_the_future
    end
    false
  end
end
