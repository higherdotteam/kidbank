class KidGrownup < ActiveRecord::Base
  belongs_to :kid
  belongs_to :grownup
end
