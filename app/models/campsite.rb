# frozen_string_literal: true

# Model for the Campsites
class Campsite < ApplicationRecord
  belongs_to :campground
  has_many :booked_dates
  validates_presence_of :campground
end
