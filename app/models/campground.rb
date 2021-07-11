# frozen_string_literal: true

class Campground < ApplicationRecord
  has_many :campsites
end
