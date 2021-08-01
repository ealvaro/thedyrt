# frozen_string_literal: true

Rails.application.routes.draw do
  resources :booked_dates
  resources :campsites

  get "campgrounds/future_booked_dates", to: "campgrounds#future_booked_dates"
  get "campgrounds/available", to: "campgrounds#available"
  get "campgrounds/by_price", to: "campgrounds#by_price"
  get "campgrounds/price_range", to: "campgrounds#price_range"
  resources :campgrounds

  get "*path", to: "errors#error404", via: :all
end
