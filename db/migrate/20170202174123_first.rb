class First < ActiveRecord::Migration
  def change
    create_table :kids do |t|
      t.string :fname
      t.string :lname
      t.datetime :dob
    end

    create_table :parents do |t|
      t.string :fname
      t.string :lname
    end

    create_table :kid_parents do |t|
      t.integer :kid_id
      t.integer :parent_id
    end
  end
end
