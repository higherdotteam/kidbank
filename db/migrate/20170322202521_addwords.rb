class Addwords < ActiveRecord::Migration
  def change
    add_column :atm_locations, :words, :string
  end
end
