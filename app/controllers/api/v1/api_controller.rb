class Api::V1::ApiController < ApplicationController
  # curl -H "Authorization: Bearer AB467-1390" http://127.0.0.1:3000/api/v1/accounts
  before_action :check_token

  def check_token
    token = request.headers['Authorization'].split(" ").last
    t=Token.where(token: token).first
    unless t
      render :text => 'token missing', status: 403
      return false
    end
    @user = t.customer
  end
  
  def accounts
    render :json => {"results": [1,2,3]}
  end
  def kids
    render :json => {"results": [1,2,3]}
  end
end

