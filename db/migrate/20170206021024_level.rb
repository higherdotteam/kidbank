class Level < ActiveRecord::Migration
  def change
    add_column :customers, :level, :integer, default: 1
  end
end
