class Observer < ActiveRecord::Base
  belongs_to :kid, class_name: 'Kid', foreign_key: 'kid_id'
  belongs_to :observer, class_name: 'Grownup', foreign_key: 'observer_id'
end
