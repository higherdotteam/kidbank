class Api::V1::CustomersController < ApplicationController

  def atms
    c=Customer.where(username: params[:id]).first
    if not c
      render json: {}, status: 406
      return
    end
    r=c.atm_events.order('happened_at desc').limit(100).as_json
    render json: {result: r}, status: 200
  end

  def create
    u = params[:username].downcase.strip
    p = params[:phone].strip
    u.gsub!(/[^0-9a-z]/i, '')
    c = Customer.where(username: u).first
    if c || u.size < 2 || p.size < 10 || u.size > 25 || p.size > 25
      render json: {}, status: 406
      return
    end
    email = "bad.email#{rand(99999999999999)}@nowhere.com"
    c=Customer.create(fname: "Not", lname: "Provided", email: email, username: u, phone: p, dob: 4.years.ago)
    render json: {result: c.as_json(platform: params[:platform])}, status: 200
  end

  def login
    u = params[:username].downcase.strip
    p = params[:password].strip
    c = Customer.where(username: u, phone: p).first
    if not c
      render json: {}, status: 406
      return
    end
    render json: {result: c.as_json(platform: params[:platform])}, status: 200
  end

  def index
    render json: {result: []}, status: 200
  end

end

