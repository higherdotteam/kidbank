class WelcomeController < ApplicationController
  def index
    @kid = Kid.new
  end
end
