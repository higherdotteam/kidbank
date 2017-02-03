class Customer < ActiveRecord::Base

  has_many :accounts, foreign_key: 'kid_id'

  def name
    fname + ' ' + lname
  end
end
