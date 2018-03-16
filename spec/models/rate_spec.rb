require 'rails_helper'

RSpec.describe Rate, type: :model do
  fixtures :rates

  describe '.at' do
    let(:base_currency) { 'SEK' }
    let(:counter_currency) { 'EUR' }
    let(:date) { Date.today.to_s }

    context 'date is present or past' do
      it 'performs a where operation with given params' do
        allow(Rate).to receive(:where).and_call_original
        parsed_date = Date.parse(date)
        rate = Rate.at(date, base_currency, counter_currency)
        expect(Rate).to have_received(:where).with(date: parsed_date,
                                                   base_currency: base_currency,
                                                   counter_currency: counter_currency)
      end

      it 'returns the expected rate' do
        expected_rate = Rate.where(date: date,
                                   base_currency: base_currency,
                                   counter_currency: counter_currency).first.rate
        rate = Rate.at(date, base_currency, counter_currency)
        expect(rate).to equal(expected_rate)
      end
    end

    context 'currencies are not supported/invalid' do
      let(:base_currency) { 'broken' }
      let(:counter_currency) { 'EUR' }
      it 'sends an error saying so' do
        expect do
          Rate.at(date, base_currency, counter_currency)
        end.to raise_error(ArgumentError, 'Invalid currency')
      end
    end

    context 'No data found' do
      let(:date) { Date.yesterday.to_s }
      it 'sends an error saying so' do
        expect do
          Rate.at(date, base_currency, counter_currency)
        end.to raise_error(ActiveRecord::RecordNotFound, 'no exchange rate was found for the data provided')
      end
    end

    context 'date is in the future' do
      let(:date) { Date.tomorrow.to_s }
      it 'sends an error saying so' do
        expect do
          Rate.at(date, base_currency, counter_currency)
        end.to raise_error(ArgumentError, 'Invalid date')
      end
    end
  end
end
