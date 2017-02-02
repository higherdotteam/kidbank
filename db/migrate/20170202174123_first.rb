class First < ActiveRecord::Migration
  def change
    create_table :kids do |t|
      t.string :fname
      t.string :lname
      t.string :email, limit: 50
      t.string :password
      t.datetime :dob
    end

    add_index :kids, :email, unique: true

    create_table :grownups do |t|
      t.string :fname
      t.string :lname
      t.string :email, limit: 50
      t.string :password
      t.integer :admin_level, default: 1
    end

    add_index :grownups, :email, unique: true

    create_table :kid_grownups do |t|
      t.integer :kid_id
      t.integer :grownup_id
    end

    create_table :accounts do |t|
      t.integer :kid_id
      t.string :flavor
      t.float :balance
    end

    create_table :activities do |t|
      t.integer :account_id
      t.float :amount
      t.string :action
    end

  end
end
