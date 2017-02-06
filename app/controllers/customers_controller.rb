class CustomersController < ApplicationController

  def edit
    @customer = current_user
    @hide_menu = true
  end

  def update
    flash[:notice] = 'Changes saved.'
    redirect_to '/'
  end

end
