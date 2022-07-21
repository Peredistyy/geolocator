# frozen_string_literal: true

class CreateGeolocations < ActiveRecord::Migration[7.0]
  def change
    create_table :geolocations do |t|
      t.string :ip
      t.string :latitude
      t.string :longitude
      t.string :country_name
      t.string :city
      t.string :zip
      t.string :data_provider
      t.text :raw
      t.timestamps
    end

    add_index :geolocations, :ip
  end
end
