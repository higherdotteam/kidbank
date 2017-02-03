class Account < ActiveRecord::Base
  belongs_to :kid
  has_many :activities
end
