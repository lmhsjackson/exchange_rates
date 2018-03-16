require 'rails_helper'

RSpec.describe RatesController, type: :controller do
  describe 'GET show' do
    let(:base_currency) { 'SEK' }
    let(:counter_currency) { 'EUR' }
    let(:date) { Date.today.to_s }

    it 'assigns @rate' do
      get :show, date: date, from: base_currency, to: counter_currency
      expect(assigns(:rate)).to eq(0.099)
    end

    it 'calls Rate at method with given params' do
      allow(Rate).to receive(:at).and_call_original
      get :show, date: date, from: base_currency, to: counter_currency
      expect(Rate).to have_received(:at).with(date, base_currency, counter_currency)
    end

    it 'renders currency error' do
      get :show, date: date, from: base_currency, to: counter_currency
      expect(json_response).to eq({'date' => Date.today.to_s,
                                   'from' => 'SEK',
                                   'rate' => 0.099,
                                   'to' => 'EUR',
      })
    end

    it 'renders currency error' do
      get :show, date: date, from: 'INVALID', to: counter_currency
      expect(json_response).to eq({'error'=>'Invalid currency'})
    end

    it 'renders date error' do
      get :show, date: Date.tomorrow.to_s, from: base_currency, to: counter_currency
      expect(json_response).to eq({'error'=>'Invalid date'})
    end

    it 'renders not found error' do
      get :show, date: Date.yesterday.to_s, from: base_currency, to: counter_currency
      expect(json_response).to eq({'error'=>'no exchange rate was found for the data provided'})
    end
  end

  def json_response
    JSON.parse(response.body)
  end
end
