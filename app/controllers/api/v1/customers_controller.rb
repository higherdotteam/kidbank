class Api::V1::CustomersController < ApplicationController

  def create
    u = params[:username].downcase
    p = params[:phone].strip
    u.gsub!(/[^0-9a-z]/i, '')
    c = Customer.where(username: u).first
    if c || u.strip.size < 2 || p.size < 10
      render json: {}, status: 406
      return
    end
    email = "bad.email#{rand(99999999999999)}@nowhere.com"
    c=Customer.create(fname: "Not", lname: "Provided", email: email, username: u, phone: p, dob: 4.years.ago)
    render json: {result: c.as_json(platform: params[:platform])}, status: 200
  end

  def index
    render json: {result: []}, status: 200
  end

end

