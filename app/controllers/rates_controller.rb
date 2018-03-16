class RatesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_error
  rescue_from ArgumentError, with: :render_error

  def show
    @rate = Rate.at(params['date'], params['from'], params['to'])

    render json: {
      date: params['date'],
      from: params['from'],
      to: params['to'],
      rate: @rate
    }.to_json
  end

  def render_error(exception)
    render json: { error: exception.message }.to_json, status: 404
    return
  end
end
