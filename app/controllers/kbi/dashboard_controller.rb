class Kbi::DashboardController < ApplicationController
  layout 'kbi'
  def welcome
    @filter = params[:filter]
    @items = Customer.all
    if @filter == 'kids'
      @items = @items.where('dob > ?', 13.years.ago)
    end
    @items.order(:id).limit(1000)
  end
end
