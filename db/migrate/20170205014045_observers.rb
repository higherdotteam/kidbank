class Observers < ActiveRecord::Migration
  def change
    create_table :observers do |t|
      t.integer :kid_id
      t.integer :observer_id
      t.string :flavor
    end
  end
end
