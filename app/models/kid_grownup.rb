class KidGrownup < ActiveRecord::Base
  belongs_to :kid, class_name: 'Kid', foreign_key: 'kid_id'
end
