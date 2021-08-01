# frozen_string_literal: true

json.array! @booked_dates, partial: "booked_dates/booked_date", as: :booked_date
