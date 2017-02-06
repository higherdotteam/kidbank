class WelcomeController < ApplicationController
  def index
    @kid = Kid.new(dob: 5.years.ago)

    if current_user
      if current_user.under_13?
        if current_user.rolled_at == nil || (Time.now.to_i - current_user.rolled_at.to_i) >= 300
          current_user.post_new_transactions()
        end
        @next_event_seconds = 300-(Time.now.to_i - current_user.rolled_at.to_i) 
      end
    end
  end
end
