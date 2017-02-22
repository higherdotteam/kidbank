class Api::V1::AtmsController < ApplicationController

  def create
    AtmLocation.create(lat: params[:lat].to_f, lon: params[:lon].to_f)
    render json: {}, status: 200
  end

end

