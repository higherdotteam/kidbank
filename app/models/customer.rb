class Customer < ActiveRecord::Base

  has_many :accounts, foreign_key: 'kid_id'
  after_create :make_tokens

  def kids
    KidGrownup.where(grownup_id: id).collect {|kg| kg.kid}
  end

  def name
    fname.to_s + ' ' + lname.to_s
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

  def make_tokens
    Token.create(customer_id: id, token: 'A'+rand(9999).to_s + '-' + rand(9999).to_s, flavor: 'apple')
    Token.create(customer_id: id, token: 'A'+rand(9999).to_s + '-' + rand(9999).to_s, flavor: 'android')

    Account.create(flavor: 'savings', balance: 100.00, kid_id: id)
  end

  
end
