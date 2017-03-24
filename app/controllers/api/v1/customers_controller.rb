class Api::V1::CustomersController < ApplicationController

  def create
    Customer.create(fname: "Not", lname: "Provided", email: params[:email], dob: 4.years.ago)
    render json: {}, status: 200
  end

  def index
    render json: {result: []}, status: 200
  end

end

