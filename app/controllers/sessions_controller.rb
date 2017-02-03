class SessionsController < ApplicationController
  def new
  end
  def create
    if params[:kid]
      session[:person_id] = Customer.first.id
    else
      session[:person_id] = Customer.last.id
    end
    redirect_to '/'
  end

  def destroy
    session[:person_id] = nil
    redirect_to root_path
  end

end
