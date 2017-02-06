class Customer < ActiveRecord::Base

  has_many :accounts, foreign_key: 'kid_id'
  after_create :make_tokens

  before_validation :make_pass

  def make_pass

    words = %W{Bat Bird Bunny Cat Chicken Crab Dog Ducks Elephant Fish Frog Giraffe Hedgehog Jellyfish Leopard 
     Monkey Moose Mouse Octopus Owl Panda Penguin Pig Rat Rabbit Reindeer Seahorse Sea Urchin
     Snake Sheep Starfish Tadpole Tiger Turkey Turtle Tortoise Zebra}

    if under_13?
      self.password = words[rand(words.size)].downcase+rand(999).to_s
      return
    end

    a=words[rand(words.size)].downcase+(rand(9)+1).to_s
    b=words[rand(words.size)].downcase+(rand(9)+1).to_s
    c=words[rand(words.size)].downcase+(rand(9)+1).to_s
    d=words[rand(words.size)].downcase+(rand(9)+1).to_s

    self.password = "#{a} #{b} #{c} #{d}"
  end

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
    return 0 unless dob
    sec = Time.now.to_i - dob.to_time.to_i
    years = (((sec / 60) / 60 / 24) / 365)
  end

  def make_tokens
    Token.create(customer_id: id, token: 'A'+rand(9999).to_s + '-' + rand(9999).to_s, flavor: 'apple')
    Token.create(customer_id: id, token: 'A'+rand(9999).to_s + '-' + rand(9999).to_s, flavor: 'android')

    Account.create(flavor: 'savings', balance: 100.00, kid_id: id)
  end

  
end
