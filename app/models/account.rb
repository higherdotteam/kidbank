class Account < ActiveRecord::Base
  belongs_to :kid
  has_many :activities

  def last_few
    activities.where('happened_at > ?', 1.month.ago).limit(5) 
  end
end
