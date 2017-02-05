class WelcomeController < ApplicationController
  def index
    @kid = Kid.new
    if current_user
      current_user.kids.each do |k|
        #todo add more
      end
    end
  end
end
