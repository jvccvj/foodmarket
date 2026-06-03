class ChartsController < ApplicationController
  def index
    @prices = Price.order(:month, :item)
  end
end