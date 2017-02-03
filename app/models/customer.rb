class Customer < ActiveRecord::Base

  has_many :accounts, foreign_key: 'kid_id'

  def name
    fname + ' ' + lname
  end

  def under_13?
    true
  end

  def under_18?
    true
  end
  
end
