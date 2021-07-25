# frozen_string_literal: true

json.extract! campground, :id, :name, :created_at, :updated_at
json.url campground_url(campground, format: :json)
