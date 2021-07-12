# frozen_string_literal: true

# Migration that creates Campgrounds
class CreateCampgrounds < ActiveRecord::Migration[5.0]
  def change
    create_table :campgrounds do |t|
      t.string :name

      t.timestamps
    end
  end
end
