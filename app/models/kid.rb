class Kid < Customer
  
  has_many :observers, :dependent => :destroy
  belongs_to :customer, :dependent => :destroy

  def non_co_parent_observers
    observers.where.not(flavor: 'co_parent').to_a
  end
  
  def co_parent
    co = observers.where(flavor: 'co_parent').first
    return 'none set yet' unless co
    co.observer.name
  end

  def self.add_to(parent, momdadplus, dob, fname, lname)
    k=Customer.create(fname: fname, lname: lname, dob: dob, email: momdadplus)

    KidGrownup.create(kid_id: k.id, grownup_id: parent.id)
  end

end
