class AddConfirmed < ActiveRecord::Migration
  def change
    add_column :atm_locations, :confirmed, :boolean, default: false
  end
end
