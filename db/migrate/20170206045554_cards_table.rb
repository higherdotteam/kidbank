class CardsTable < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :kid_id
      t.float :amount
      t.string :action
      t.string :flavor
      t.datetime :happened_at
    end

  end
end
