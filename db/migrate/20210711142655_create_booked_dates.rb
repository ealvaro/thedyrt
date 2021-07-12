# frozen_string_literal: true

# Migration that creates Booked Dates for Campsites
class CreateBookedDates < ActiveRecord::Migration[5.0]
  def change
    create_table :booked_dates do |t|
      t.date :check_in_date
      t.date :check_out_date
      t.references :campsite, foreign_key: true

      t.timestamps
    end
  end
end
