# frozen_string_literal: true

Rails.application.routes.draw do
  resources :booked_dates
  resources :campsites
  resources :campgrounds

  get '*path', to: 'errors#error_404', via: :all
end
