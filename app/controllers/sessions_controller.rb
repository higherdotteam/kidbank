class SessionsController < ApplicationController
  def new
    @customer = Customer.new
    @hide_menu = true
  end
  def create
    if params[:kid]
      session[:person_id] = Customer.first.id
    else
      session[:person_id] = Customer.find_by_email('andrew@higher.team').id
    end
    redirect_to '/'
  end

  def destroy
    session[:person_id] = nil
    redirect_to root_path
  end

end
