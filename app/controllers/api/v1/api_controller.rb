class Api::V1::ApiController < ApplicationController
  # curl -H "Authorization: Bearer AB467-1390" http://127.0.0.1:3000/api/v1/accounts
  before_action :check_token

  def check_token
    raw = request.headers['Authorization']
    unless raw
      render :text => 'token missing', status: 403
      return false
    end
    token = raw.split(" ").last
    t=Token.where(token: token).first
    unless t
      render :text => 'token missing', status: 403
      return false
    end
    @user = t.customer
  end
  
  def accounts
    render :json => @user.accounts.as_json
  end
  def kids
    render :json => {"results": [1,2,3]}
  end
  def coparents
	render :json => Customer.where('dob > ?', 18.years.ago).limit(10).as_json
  end
end

