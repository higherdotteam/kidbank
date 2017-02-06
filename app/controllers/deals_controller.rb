class DealsController < ApplicationController

  def update
    a = Asset.find(params[:id])
    a.transaction do
      if params[:source] == 'c'
        a.customer.checking += a.value
      elsif params[:source] == 's'
        a.customer.savings += a.value
      elsif params[:source] == 'l'
        a.customer.loan += a.value
      end
      a.destroy
      a.customer.save
    end
    redirect_to '/'
  end

end
