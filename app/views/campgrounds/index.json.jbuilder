# frozen_string_literal: true

json.array! @campgrounds, partial: "campgrounds/campground", as: :campground
