class Phone < ActiveRecord::Migration
  def change
    add_column :customers, :phone, :string, limit: 50
  end
end
