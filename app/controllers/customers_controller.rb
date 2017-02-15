class CustomersController < ApplicationController

  def edit
    @customer = current_user
    @hide_menu = true
  end

  def update
    c = Customer.find(params[:id])

    # { "customer"=>{"fname"=>"Andrew", "lname"=>"Arrow", "email"=>"andrew@higher.team", "dob(1i)"=>"1977", "dob(2i)"=>"2", "dob(3i)"=>"14"}, "commit"=>"Save Changes", "controller"=>"customers", "action"=>"update", "id"=>"70"}
    
    c.fname = params[:customer][:fname]
    c.lname = params[:customer][:lname]
    c.email = params[:customer][:email]
    c.dob = Date.parse(params[:customer]['dob(1i)']+'-'+ params[:customer]['dob(2i)'] + '-'+ params[:customer]['dob(3i)'])
    c.save
    flash[:notice] = 'Changes saved.'
    redirect_to '/'
  end

end
