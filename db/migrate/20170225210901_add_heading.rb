class AddHeading < ActiveRecord::Migration
  def change
    add_column :atm_locations, :heading, :decimal
  end
end
