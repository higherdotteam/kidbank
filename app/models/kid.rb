class Kid < Customer
  
  has_many :observers, :dependent => :destroy

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

    KidGrownup.create(kid_id: k.id, grownup_id: parent.id)
  end
end
