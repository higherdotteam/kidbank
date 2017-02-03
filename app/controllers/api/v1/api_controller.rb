class Api::V1::ApiController < ApplicationController
  def accounts
    render :json => {"results": [1,2,3]}
  end
  def kids
    render :json => {"results": [1,2,3]}
  end
end

