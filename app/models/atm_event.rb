class AtmEvent < ActiveRecord::Base

  belongs_to :customer
  belongs_to :atm, class_name: 'AtmLocation', foreign_key: 'atm_id'

  def as_json
    r = {}
    r[:id] = id
    r[:words] = atm.words
    r[:happened_at] = happened_at
    r[:flavor] = flavor
  end

end
