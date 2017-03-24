class Api::V1::CustomersController < ApplicationController

  def create
    c = Customer.where(username: params[:username]).first
    if c
      render json: {}, status: 406
      return
    end
    Customer.create(fname: "Not", lname: "Provided", username: params[:username], dob: 4.years.ago)
    render json: {}, status: 200
  end

  def index
    render json: {result: []}, status: 200
  end

end

