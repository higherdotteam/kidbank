class AddAssetts < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.integer :customer_id
      t.string :flavor
      t.float :paid
      t.float :value
      t.datetime :aquired_at
    end
  end
end
