class WelcomeController < ApplicationController
  def index
    @kid = Kid.new(dob: 5.years.ago)

    if current_user
      if current_user.under_13?
        if current_user.rolled_at == nil || (current_user.rolled_at.day != Time.now.day)
          current_user.post_new_transactions()
        end
        @next_event_seconds = Time.now.to_i - current_user.rolled_at.tomorrow.midnight.to_i
        @next_event_mins = @next_event_seconds / 60
        @next_event_hours = @next_event_mins.to_f / 60.0
        @next_event_hours *= -1
      end
    end
  end
end
