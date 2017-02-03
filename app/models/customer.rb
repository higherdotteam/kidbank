class Customer < ActiveRecord::Base

  has_many :accounts, foreign_key: 'kid_id'

  def kids
    KidGrownup.where(grownup_id: id).collect {|kg| kg.kid}
  end

  def name
    fname + ' ' + lname
  end

  def under_13?
    age < 13
  end

  def under_18?
    age < 18
  end

  def age
    sec = Time.now.to_i - dob.to_time.to_i
    years = (((sec / 60) / 60 / 24) / 365)
  end
  
end
