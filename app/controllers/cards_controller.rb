class CardsController < ApplicationController

  def destroy
    c = Card.find(params[:id])
    if c.flavor == 'deal'
      c.destroy
    end
    redirect_to '/'
  end
end
