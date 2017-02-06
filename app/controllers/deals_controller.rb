class DealsController < ApplicationController

  def update
    a = Asset.find(params[:id])
    s = params[:source]
    redirect_to '/'
  end

end
