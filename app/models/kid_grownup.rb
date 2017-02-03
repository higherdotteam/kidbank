class KidGrownup < ActiveRecord::Base
  belongs_to :kid, class_name: 'Customer', foreign_key: 'kid_id'
end
