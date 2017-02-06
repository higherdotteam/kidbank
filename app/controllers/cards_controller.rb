class CardsController < ApplicationController

  def update
    c = Card.find(params[:id])
    if c.flavor == 'bill'
      c.transaction do
        c.customer.checking += c.amount
        c.destroy
        c.customer.save
      end
    end
    redirect_to '/'
  end
  def destroy
    c = Card.find(params[:id])
    if c.flavor == 'deal'
      c.destroy
    end
    redirect_to '/'
  end
end
