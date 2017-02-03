class Kid < ActiveRecord::Base

  has_many :accounts

  def name
    fname + ' ' + lname
  end
end
