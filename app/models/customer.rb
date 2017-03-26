class Customer < ActiveRecord::Base

  has_many :accounts, foreign_key: 'kid_id', :dependent => :destroy
  has_many :cards, foreign_key: 'kid_id', :dependent => :destroy
  has_many :assets, :dependent => :destroy
  has_many :tokens, :dependent => :destroy
  hash_many :atm_events, :dependent => :destroy
  after_create :make_tokens

  validates_presence_of :fname, :lname
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  before_validation :make_pass

  def as_json(options={})
    r = {}
    r[:id] = id
    r[:name] = name
    r[:username] = username
    if options[:platform] == 'android'
      r[:token] = tokens.where(flavor: 'android').first.token
    else
      r[:token] = tokens.where(flavor: 'apple').first.token
    end
    r
  end

  def level_text
    BANK_TERMS[level-1]
  end

  def total_cash
    checking.to_f+savings.to_f
  end

  def net_worth
    bills = -1*cards.where(flavor: 'bill').sum(:amount)
    asum = 0
    assets.each do |a|
      asum += a.value
    end
    (asum + total_cash) - (-1*loan) - bills
  end

  def post_new_transactions
    if rand(4) == 2
      cards.create(kid_id: id, flavor: 'deal', action: COMMON_DEALS[rand(COMMON_DEALS.size)], 
                   amount: "-#{rand(999)}.#{rand(99)}".to_f, 
                   happened_at: Time.now)
    elsif rand(4) == 1
      cards.create(kid_id: id, flavor: 'check', action: COMMON_INCOME[rand(COMMON_INCOME.size)], 
                   amount: "#{rand(999)}.#{rand(99)}".to_f, 
                   happened_at: Time.now)
    else
      cards.create(kid_id: id, flavor: 'bill', action: COMMON_BILLS[rand(COMMON_BILLS.size)], 
                   amount: "-#{rand(999)}.#{rand(99)}".to_f, 
                   happened_at: Time.now)
    end
    update_attributes(rolled_at: Time.now)
  end

  def make_pass
    
    self.checking = 1000.00 unless checking
    self.savings = 0 unless savings
    self.loan = 0 unless loan

    return if password

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
    post_new_transactions
    post_new_transactions
    post_new_transactions
    post_new_transactions
    post_new_transactions
    post_new_transactions
    post_new_transactions
    post_new_transactions
  end

  
end
