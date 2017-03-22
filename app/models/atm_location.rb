class AtmLocation < ActiveRecord::Base

  after_create :lookup_words

  def self.words
    AtmLocation.find_each do |a|
      a.lookup_words
      puts a.words
      a.save
    end
  end

  def lookup_words
    url = "https://api.what3words.com/v2/reverse?coords=#{lat},#{lon}&display=full&format=json&key=#{ENV['W3W']}"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    data = JSON.parse(response.body)
    a.words = data['words']
  end

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
    r = []
    results.to_a.each do |item|
      # => [1, #<BigDecimal:7f8252718898,'0.333E2',18(27)>, #<BigDecimal:7f82527187f8,'-0.1181E3',18(27)>, nil, 7883.2201509116285]
      r << {lat: item[1].to_f, lon: item[2].to_f, distance: item[4]}
    end
    r
  end

  def image_name
    ids = id.to_s
    p1 = ids[ids.size-1]
    p2 = ids[ids.size-2]
    "#{p2}/#{p1}/#{ids}.jpg"
  end
end
