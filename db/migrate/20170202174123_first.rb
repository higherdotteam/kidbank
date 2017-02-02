class First < ActiveRecord::Migration
  def change
    create_table :kids do |t|
      t.string :fname
      t.string :lname
      t.string :email
      t.string :password
      t.datetime :dob
    end

    create_table :parents do |t|
      t.string :fname
      t.string :lname
      t.string :password
      t.string :email
    end

    create_table :kid_parents do |t|
      t.integer :kid_id
      t.integer :parent_id
    end

    create_table :accounts do |t|
      t.integer :kid_id
      t.string :flavor
      t.integer :balance
    end

    create_table :activities do |t|
      t.integer :account_id
      t.integer :amount
      t.string :action
    end

    create_table :admins do |t|
      t.string :fname
      t.string :lname
      t.string :email
      t.string :password
      t.integer :level, default: 1
    end
  end
end
