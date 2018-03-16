class RatesController < ApplicationController

  def show
    @rate = Rate.at(params['date'], params['from'], params['to'])

    render json: {
      date: params['date'],
      from: params['from'],
      to: params['to'],
      rate: @rate
    }.to_json

  end
end
