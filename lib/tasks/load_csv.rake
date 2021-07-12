require 'csv'
require 'json'
require 'byebug'

namespace :db do
  desc "This task will load a file of Campgrounds and Campsites"
  task load: :environment do
    LOAD_PATH = File.expand_path('../../loads', __dir__)
    CSV.open("#{LOAD_PATH}/sample_campground_data.csv", headers: true).each do |line|
      campground_name = line['campground_name']
      unless campground_name.nil? || campground_name.empty?
        campsite_name = line['campsite_name']
        unless campsite_name.nil? || campsite_name.empty?
          campsite_price = line['price_usd'].to_i
          cmp_grnd = Campground.find_by_name(campground_name)
          if cmp_grnd
            Campsite.create!(name: campsite_name, price: campsite_price, campground: cmp_grnd)
          else
            Campsite.create!(name: campsite_name, price: campsite_price, campground: Campground.create!(name: campground_name))
          end
        end
      end
    end
  end
end
