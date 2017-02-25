class AtmLocation < ActiveRecord::Base

  def as_json
    r = {}
    r[:lat] = lat.to_f
    r[:lon] = lon.to_f
    r[:h] = heading.to_f
    r
  end
end
