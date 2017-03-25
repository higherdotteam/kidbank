class Token < ActiveRecord::Base

  belongs_to :customer 

  def as_json
    r = {}
    r[:id] = id
    r[:token] = token
    r[:flavor] = flavor
    r
  end
end
