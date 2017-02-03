class Customer < ActiveRecord::Base

  def name
    fname + ' ' + lname
  end
end
