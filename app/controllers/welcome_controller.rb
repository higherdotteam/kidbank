class WelcomeController < ApplicationController
  def index
    @kid = Kid.new(dob: 5.years.ago)

    if current_user
      if current_user.under_13?
        if current_user.last_rolled == nil || (current_user.last_rolled.day != Time.now.day)
          current_user.update_attributes(last_rolled: Time.now)
        end
      end
    end
  end
end
