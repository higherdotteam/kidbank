class CardsController < ApplicationController

  def update
    c = Card.find(params[:id])
    if c.flavor == 'bill'
      c.transaction do
        if params[:source] == 'c'
          c.customer.checking += c.amount
        elsif params[:source] == 's'
          c.customer.savings += c.amount
        elsif params[:source] == 'l'
          c.customer.loan += c.amount
        end
        c.destroy
        c.customer.save
      end
    elsif c.flavor == 'deal'
      c.transaction do
        # TODO add asset
        if params[:source] == 'c'
          c.customer.checking += c.amount
        elsif params[:source] == 's'
          c.customer.savings += c.amount
        elsif params[:source] == 'l'
          c.customer.loan += c.amount
        end
        c.destroy
        c.customer.save
      end
    elsif c.flavor == 'check'
      c.transaction do
        if params[:source] == 'c'
          c.customer.checking += c.amount
        elsif params[:source] == 's'
          c.customer.savings += c.amount
        elsif params[:source] == 'l'
          c.customer.loan += c.amount
        end
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
