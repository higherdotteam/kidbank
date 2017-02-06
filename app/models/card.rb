class Card < ActiveRecord::Base
  

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
