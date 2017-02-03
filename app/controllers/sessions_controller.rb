class SessionsController < ApplicationController
  def new
    session[:person_id] = 1
    redirect_to '/'
  end
end
