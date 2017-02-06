class AddLast < ActiveRecord::Migration
  def change
    add_column :customers, :rolled_at, :datetime
  end
end
