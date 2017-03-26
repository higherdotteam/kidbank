class AtmEvent < ActiveRecord::Base

  belongs_to :customer

  def as_json
    r = {}
    r[:id] = id
    r[:words] = words
    r[:happened_at] = happened_at
    r[:flavor] = flavor
  end

end
