# frozen_string_literal: true

# Model for the Campsite's Booked Dates
class BookedDate < ApplicationRecord
  belongs_to :campsite

  def in_the_future
    # Only interested in future booked dates from today
    return true if check_out_date >= Date.today
  end
end
