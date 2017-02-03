class Tokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.integer :customer_id
      t.string :token, limit: 50
      t.string :flavor
    end
    add_index :tokens, :token, unique: true
  end
end
