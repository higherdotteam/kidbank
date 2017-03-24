class Api::V1::CustomersController < ApplicationController

  def create
    u = params[:username].downcase
    c = Customer.where(username: u).first
    if c
      render json: {}, status: 406
      return
    end
    email = "bad.email#{rand(99999999999999)}@nowhere.com"
    Customer.create(fname: "Not", lname: "Provided", email: email, username: u, dob: 4.years.ago)
    render json: {}, status: 200
  end

  def index
    render json: {result: []}, status: 200
  end

end

