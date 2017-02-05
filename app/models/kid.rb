class Kid < Customer
  
  has_many :observers, :dependent => :destroy
  belongs_to :customer, :dependent => :destroy
  before_validation :make_pass

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

  def make_pass

    words = %W{Bat Bird Bunny Cat Chicken Crab Dog Ducks Elephant Fish Frog Giraffe Hedgehog Jellyfish Leopard 
     Monkey Moose Mouse Octopus Owl Panda Penguin Pig Rat Rabbit Reindeer Seahorse Sea Urchin
     Snake Sheep Starfish Tadpole Tiger Turkey Turtle Tortoise Zebra}

    self.password = words[rand(words.size)].downcase+rand(999).to_s
  end
end
