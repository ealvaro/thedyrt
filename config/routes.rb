# frozen_string_literal: true

Rails.application.routes.draw do
  resources :booked_dates
  resources :campsites

  get 'campgrounds/future_booked_dates', to: 'campgrounds#future_booked_dates'
  get 'campgrounds/available', to: 'campgrounds#available'
  resources :campgrounds

  get '*path', to: 'errors#error404', via: :all
end
