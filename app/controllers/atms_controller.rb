class AtmsController < ApplicationController
  def index
    @list = AtmLocation.all.order('id').limit(1000)
  end
end

