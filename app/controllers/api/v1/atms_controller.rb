require 'fileutils'
class Api::V1::AtmsController < ApplicationController

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

  def rotate?(file)
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

