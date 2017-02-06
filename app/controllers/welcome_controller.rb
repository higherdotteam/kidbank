class WelcomeController < ApplicationController
  def index
    @kid = Kid.new(dob: 5.years.ago)

    if current_user
      if current_user.under_13?
        if current_user.rolled_at == nil || (current_user.rolled_at.day != Time.now.day)
          current_user.update_attributes(rolled_at: Time.now)
        end
      end
    end
  end
end
