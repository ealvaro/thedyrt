# frozen_string_literal: true

# Migration that creates Campsites
class CreateCampsites < ActiveRecord::Migration[5.0]
  def change
    create_table :campsites do |t|
      t.string :name
      t.integer :price
      t.references :campground, foreign_key: true

      t.timestamps
    end
  end
end
