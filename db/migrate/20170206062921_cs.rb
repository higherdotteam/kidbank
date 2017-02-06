class Cs < ActiveRecord::Migration
  def change
    add_column :customers, :checking, :float
    add_column :customers, :savings, :float
    add_column :customers, :loan, :float

  end
end
