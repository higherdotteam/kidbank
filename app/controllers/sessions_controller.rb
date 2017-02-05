class SessionsController < ApplicationController

  def new
    @customer = Customer.new
    @hide_menu = true
  end

  def create
    # "customer"=>{"email"=>"wefwefwef", "password"=>"wfwefwefwef"},
    #
    c = Customer.find_by_email(params[:customer][:email])
    unless c
      flash[:notice] = 'Check that email make sure you typed it exactly right.'
      redirect_to '/sessions/new'
      return
    end
    
    if c.password == params[:customer][:password]
      session[:person_id] = c.id
      redirect_to '/'
      return
    else
      flash[:notice] = 'Check that password make sure you typed it exactly right.'
      redirect_to '/sessions/new'
      return
    end
  end

  def destroy
    session[:person_id] = nil
    redirect_to root_path
  end

end
