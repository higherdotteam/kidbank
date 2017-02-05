class Kid < Customer
  
  has_many :observers, :dependent: 'destory'

  def non_co_parent_observers
    observers.where.not(flavor: 'co_parent').to_a
  end
  
  def co_parent
    co = observers.where(flavor: 'co_parent').first
    return 'none set yet' unless co
    co.observer.name
  end

  def self.add_to(parent)
    k=Customer.create(fname: 'Kid', lname: 'Smith', dob: 7.years.ago, email: "s+#{rand(999999999999)}@kid.org", password: '123')

    #TODO place in customer model auto gen token
    Token.create(customer_id: k.id, token: 'AB467-'+rand(9999).to_s, flavor: 'apple')
    Token.create(customer_id: k.id, token: 'AB467-'+rand(9999).to_s, flavor: 'android')
    Token.create(customer_id: k.id, token: 'AB467-'+rand(9999).to_s, flavor: 'html5')

    Account.create(flavor: 'checkings', balance: 100.00, kid_id: k.id)
    Account.create(flavor: 'savings', balance: 1000.00, kid_id: k.id)

    KidGrownup.create(kid_id: k.id, grownup_id: parent.id)
  end
end
