require 'fileutils'
class Api::V1::AtmsController < ApplicationController

  def deposit
    t=Token.where(token: params[:token]).first

    if not t
      render json: {}, status: 406
      return
    end

    ae = AtmEvent.where(customer_id: t.customer_id, atm_id: params[:id].to_i, flavor: 'deposit').first

    if ae and ae.happened_at.strftime("%m/%d/%Y") == Time.now.strftime("%m/%d/%Y")
      render json: {}, status: 200
      return
    end

    AtmEvent.create(customer_id: t.customer_id, atm_id: params[:id].to_i, flavor: 'deposit', happened_at: Time.now)
    render json: {}, status: 200
  end

  def create
    #params[:image].original_filename
    al=AtmLocation.create(lat: params[:lat].to_f, lon: params[:lon].to_f, heading: params[:h].to_f)
    data = params[:image].read
    ids = al.id.to_s
    p1 = ids[ids.size-1]
    p2 = ids[ids.size-2]
    # https://kidbank.team/images/atms/2/3/123.jpg
    dir = "/www/kidbank/public/images/atms/#{p2}/#{p1}"
    FileUtils.mkdir_p dir
    fn = dir+"/#{ids}.jpg"
    File.open(fn, "wb") { |f| f.write(data) }
    if rotate?(fn) 
      `exiftool -all= #{fn}`
      `convert #{fn} -rotate 90 #{fn}`
    end
    render json: {}, status: 200
  end

  def rotate?(f)
    d = `exiftool #{f}`
    d.split("\n").each do |line|
      next unless line.index('Orientation')
      next unless line.index('Rotate 90 CW')
      return true
    end
    false
  end

  def index
    list = AtmLocation.nearby(params[:lat].to_f, params[:lon].to_f)
    render json: {result: list.as_json}, status: 200
  end

end

