# frozen_string_literal: true

json.array! @campgrounds, partial: 'campgrounds/campground_simple', as: :campground
