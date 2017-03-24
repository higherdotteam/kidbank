class AtmsController < ApplicationController
  def index
    @list = AtmLocation.where(confirmed: true).order('id').limit(1000)
  end
end

