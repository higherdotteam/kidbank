class Card < ActiveRecord::Base
  
  belongs_to :customer, foreign_key: 'kid_id'

  def action_text
    if flavor == 'deal'
      'BUY!'
    elsif flavor == 'check'
      'Deposit'
    else
      'Pay'
    end
  end

end
