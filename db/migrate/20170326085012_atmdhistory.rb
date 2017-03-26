class Atmdhistory < ActiveRecord::Migration
  def change
    create_table :atm_events do |t|
      t.string :flavor
      t.datetime :happened_at
      t.integer :customer_id
      t.integer :atm_id
    end

  end
end
