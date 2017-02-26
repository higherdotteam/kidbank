class AtmLocation < ActiveRecord::Base

  def as_json
    r = {}
    r[:lat] = lat.to_f
    r[:lon] = lon.to_f
    r[:h] = heading.to_f
    r
  end

  def self.nearby(lat, lon)
    sql = "SELECT *, 3956 * 2 * ASIN(SQRT( POWER(SIN((#{lat} - abs( dest.lat)) * pi()/180 / 2),2) + COS(#{lat} * pi()/180 ) * COS( abs (dest.lat) *  pi()/180) * POWER(SIN((#{lon}-dest.lon) *  pi()/180 / 2), 2) )) as distance FROM atm_locations dest order by distance limit 100;"
    results = AtmLocation.connection.execute(sql)
    raise results.inspect
  end
end
