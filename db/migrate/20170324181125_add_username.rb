class AddUsername < ActiveRecord::Migration
  def change
    add_column :customers, :username, :string, limit: 50
    add_index :customers, :username, unique: true
  end
end
