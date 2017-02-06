class CustomersController < ApplicationController

  def edit
    @customer = current_user
    @hide_menu = true
  end

  def update
  end

end
