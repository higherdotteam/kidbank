class SessionsController < ApplicationController
  def new
  end
  def create
    session[:person_id] = Customer.last.id
    redirect_to '/'
  end

  def destroy
    session[:person_id] = nil
    redirect_to root_path
  end

end
