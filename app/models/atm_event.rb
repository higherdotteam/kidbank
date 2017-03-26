class AtmEvent < ActiveRecord::Base

  belongs_to :customer
  belongs_to :atm_location

  def as_json
    r = {}
    r[:id] = id
    r[:words] = atm_location.words
    r[:happened_at] = happened_at
    r[:flavor] = flavor
  end

end
