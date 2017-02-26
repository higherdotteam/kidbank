class Api::V1::AtmsController < ApplicationController

  def create
    AtmLocation.create(lat: params[:lat].to_f, lon: params[:lon].to_f, heading: params[:h].to_f)
    render json: {}, status: 200
  end

  def index
    list = AtmLocation.nearby(params[:lat].to_f, params[:lon].to_f)
    render json: {result: list.as_json}, status: 200
  end

end

