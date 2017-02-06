class WelcomeController < ApplicationController
  def index
    @kid = Kid.new(dob: 5.years.ago)
  end
end
