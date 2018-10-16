class FlightsController < ApplicationController
  def index
    flights = Flight.filter(params[:filter])
    render json: flights
  end
end
