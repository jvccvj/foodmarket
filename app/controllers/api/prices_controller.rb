module Api
  class PricesController < ApplicationController
    skip_before_action :verify_authenticity_token
    
    def index
      prices = Price.order(:recorded_at)
      render json: {
        prices: prices.map { |p|
          {
            id: p.id,
            item: p.item,
            price: p.price.to_f,
            day: p.day,
            month: p.month,
            unit: p.unit,
            recorded_at: p.recorded_at.iso8601
          }
        }
      }
    end
    
    def show
      price = Price.find(params[:id])
      render json: {
        price: {
          id: price.id,
          item: price.item,
          price: price.price.to_f,
          day: price.day,
          month: price.month,
          unit: price.unit,
          recorded_at: price.recorded_at.iso8601
        }
      }
    end
  end
end