class Account < ActiveRecord::Base
  belongs_to :kid
  has_many :activities

  def last_few
    [1,2,3]
  end
end
