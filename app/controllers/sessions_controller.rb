class SessionsController < ApplicationController
  def new
    session[:person_id] = Kid.first.id
    redirect_to '/'
  end
end
