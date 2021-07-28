# frozen_string_literal: true

# Model for the Campsite's Booked Dates
class BookedDate < ApplicationRecord
  belongs_to :campsite
  validates_presence_of :campsite, :check_in_date, :check_out_date
  validate :check_out_after_check_in

  def in_the_future
    # Only interested in future booked dates from today
    return true if check_out_date >= Date.today

    false
  end

  private

  def check_out_after_check_in
    return if check_out_date.blank? || check_in_date.blank?

    errors.add(:check_out_date, 'must be after the check_in date') if check_out_date < check_in_date
  end
end
