class CreateAtmLocations < ActiveRecord::Migration
  def change
    create_table :atm_locations do |t|
      t.float :lat
      t.float :lon
    end
  end
end
