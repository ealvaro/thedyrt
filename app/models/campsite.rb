# frozen_string_literal: true

class Campsite < ApplicationRecord
  belongs_to :campground
  has_many :booked_dates
end
