# frozen_string_literal: true

json.extract! campsite, :id, :name, :price, :campground_id, :created_at, :updated_at
json.url campsite_url(campsite, format: :json)
json.booked_dates campsite.booked_dates, partial: "booked_dates/booked_date", as: :booked_date
