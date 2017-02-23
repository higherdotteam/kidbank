class AddScale < ActiveRecord::Migration
  def change
    change_column :atm_locations, :lat, :decimal, :precision => 20, :scale => 15
    change_column :atm_locations, :lon, :decimal, :precision => 20, :scale => 15
    #33.983038432805429
    #-118.39354963984191
  end
end
